class ShibesController < ApplicationController
  
  def show
    @shibe = Shibe.find(params[:id])
  end

  def new
  	@shibe = Shibe.new
  end

  def create
    @shibe = Shibe.new(shibe_params)    # Not the final implementation!
    if @shibe.save
      flash[:success] = "Wow.  Such Welcome.  So Taco."
      redirect_to @shibe
    else
      render 'new'
    end
  end

  private

    def shibe_params
      params.require(:shibe).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
