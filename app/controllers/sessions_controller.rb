class SessionsController < ApplicationController

	def new
  end

  def create
  	shibe = Shibe.find_by(email: params[:session][:email].downcase)
  if shibe && shibe.authenticate(params[:session][:password])
    sign_in shibe
    redirect_back_or shibe
  else
    flash.now[:error] = 'Invalid email/password combination' # Not quite right!
    render 'new'
  end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
