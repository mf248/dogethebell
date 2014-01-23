require 'spec_helper'

describe Link do

  let(:shibe) { FactoryGirl.create(:shibe) }
  before { @link = shibe.links.build(title: "Lorem ipsum", address: "google.com") }

  subject { @link }

  it { should respond_to(:title) }
  it { should respond_to(:address) }
  it { should respond_to(:shibe_id) }
  it { should respond_to(:shibe) }

  it { should be_valid }

  describe "when shibe_id is not present" do
  	before { @link.shibe_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank title" do
  	before { @link.title = " " }
  	it { should_not be_valid }
  end

  describe "with no address" do
  	before { @link.address = " "}
  	it { should_not be_valid }
  end

  describe "with title that is too long" do
  	before { @link.title = "a" * 51 }
  	it { should_not be_valid }
  end
end
