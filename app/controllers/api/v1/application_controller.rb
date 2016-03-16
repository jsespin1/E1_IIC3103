module Api
	module V1
		class ApplicationController 
		  # Prevent CSRF attacks by raising an exception.
		  # For APIs, you may want to use :null_session instead.

		  	def status
		  		render :nothing => true, :status => 201

		  	end


		  protect_from_forgery with: :null_session
		end
	end
end