require 'spec_helper'

describe Shibe do

  before do
  	@shibe = Shibe.new(name: "Example User", email: "user@example.com",
  						password: "foobar", password_confirmation: "foobar")
  end

  subject { @shibe }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:links) }

  it { should be_valid }

  describe "when name is not present" do
    before { @shibe.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @shibe.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @shibe.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @shibe.email = invalid_address
        expect(@shibe).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @shibe.email = valid_address
        expect(@shibe).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      shibe_with_same_email = @shibe.dup
      shibe_with_same_email.email = @shibe.email.upcase
      shibe_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @shibe = Shibe.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @shibe.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @shibe.password = @shibe.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @shibe.save }
    let(:found_shibe) { Shibe.find_by(email: @shibe.email) }

    describe "with valid password" do
      it { should eq found_shibe.authenticate(@shibe.password) }
    end

    describe "with invalid password" do
      let(:shibe_for_invalid_password) { found_shibe.authenticate("invalid") }

      it { should_not eq shibe_for_invalid_password }
      specify { expect(shibe_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @shibe.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "link associations" do
    
    before { @shibe.save }
    let!(:older_link) do
      FactoryGirl.create(:link, shibe: @shibe, created_at: 1.day.ago)
    end
    let!(:newer_link) do
      FactoryGirl.create(:link, shibe: @shibe, created_at: 1.hour.ago)
    end

    it "should have the right links in the right order" do
      expect(@shibe.links.to_a).to eq [newer_link, older_link]
    end
  end
end



