module SessionsHelper
	def sign_in(shibe)
    remember_token = Shibe.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    shibe.update_attribute(:remember_token, Shibe.encrypt(remember_token))
    self.current_shibe = shibe
  end

  def signed_in?
    !current_shibe.nil?
  end
  
  def current_shibe=(shibe)
    @current_shibe = shibe
  end

  def current_shibe
    remember_token = Shibe.encrypt(cookies[:remember_token])
    @current_shibe ||= Shibe.find_by(remember_token: remember_token)
  end

  def sign_out
    current_shibe.update_attribute(:remember_token,
                                  Shibe.encrypt(Shibe.new_remember_token))
    cookies.delete(:remember_token)
    self.current_shibe = nil
  end
end