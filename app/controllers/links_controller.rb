class LinksController < ApplicationController
	before_action :signed_in_shibe, only: [:create]

	def create
		@link = current_shibe.links.build(link_params)
    if @link.save
    	if !(@link.address =~ /^https?:/i)
    		@link.address = "http://" + @link.address
  	  		@link.save
  	  			if @link.save
      				flash[:success] = "Wow.  Such link."
      				redirect_to shibe_path(@link.shibe)
      			else
      				redirect_to shibe_path(@link.shibe)
      			end
      		else
      		@link.address.insert(0, "http://")
      		@link.address.add_quotes
  	  		@link.save
  	  			if @link.save
      				flash[:success] = "Wow.  Such link."
      				redirect_to shibe_path(@link.shibe)
      			else
      				redirect_to shibe_path(@link.shibe)
      			end
      	end
    else
      redirect_to shibe_path(@link.shibe)
    end
	end

	def index
		@links = Link.all
    end

    private

    def link_params
    	params.require(:link).permit(:title, :address)
    end
end