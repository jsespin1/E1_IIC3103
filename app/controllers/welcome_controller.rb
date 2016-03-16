class WelcomeController < ApplicationController

	respond_to :json
	rescue_from StandardError, :with => :handle_exception

	def index
	end


	def validarFirma
		http = 200
		valido = true
		#Manejamos un error de formato 
		begin

			if params[:mensaje].present? & params[:hash]
				http = 200
			else
				redirect_to welcome_error400_path
				return
			end


			if params[:mensaje].kind_of?(String) & params[:hash].kind_of?(String)
				mensaje = params[:mensaje].to_s
				hash_mensaje = params[:hash].to_s
				hash_real = Digest::SHA256.hexdigest(mensaje)
				if hash_real == hash_mensaje
					valido = true
				else
					valido = false
				end
			else
				if http != 400
					redirect_to welcome_error500_path
					return
				end
			end

			render json: {:valido => valido, :mensaje => mensaje}

		rescue StandardError => ex 
			redirect_to welcome_error500_path
		end

	end

	def status
		redirect_to welcome_status201_path
	end

	def status201
		render status: 201
	end

	def error400
		render status: 400
	end

	def error500
		render status: 500
	end

	def handle_exception

	end

	
end
