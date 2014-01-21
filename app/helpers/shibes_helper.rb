module ShibesHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(shibe)
    gravatar_id = Digest::MD5::hexdigest(shibe.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: shibe.name, class: "gravatar")
  end

 
end
