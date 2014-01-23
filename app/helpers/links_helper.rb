module LinksHelper
  def current_shibe
    remember_token = Shibe.encrypt(cookies[:remember_token])
    @current_shibe ||= Shibe.find_by(remember_token: remember_token)
  end
end