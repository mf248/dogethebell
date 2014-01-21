class ShibesController < ApplicationController
  before_action :signed_in_shibe, only: [:edit, :update]
  before_action :correct_shibe,   only: [:edit, :update]

  def show
    @shibe = Shibe.find(params[:id])
  end

  def new
  	@shibe = Shibe.new
  end

  def create
    @shibe = Shibe.new(shibe_params)    # Not the final implementation!
    if @shibe.save
      sign_in @shibe
      flash[:success] = "Wow.  Such Welcome.  So Taco."
      redirect_to @shibe
    else
      render 'new'
    end
  end

  def edit
    @shibe = Shibe.find(params[:id])
  end

  def update
    @shibe = Shibe.find(params[:id])
    if @shibe.update_attributes(shibe_params)
      flash[:success] = "Profile updated.  Wow."
      redirect_to @shibe
    else
      render 'edit'
    end
  end

  def index
    @shibes = Shibe.all
  end 

  private

    def shibe_params
      params.require(:shibe).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_shibe
      unless signed_in?
        store_location
      redirect_to signin_url, notice: "Shibe, please sign in." unless signed_in?
    end

    def correct_shibe
      @shibe = Shibe.find(params[:id])
      redirect_to(root_url) unless current_shibe?(@shibe)
    end
  end
end
