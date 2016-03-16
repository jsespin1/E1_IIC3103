module Api
		class ApplicationController < ActionController::Base
			include ActionController::MimeResponds
			respond_to :json


			def validarFirma
				http = 200
				valido = true
				texto ="todo bien"
				#Vemos la correctitud de los parametros
				if params[:mensaje].present? & params[:hash]
					http = 200
				else
					http = 400
					valido = false
					texto = "Parametros Incorrectos"
				end
				if params[:mensaje].kind_of?(String) & params[:hash].kind_of?(String)
					mensaje = params[:mensaje].to_s
					hash_mensaje = params[:hash].to_s
					hash_real = Digest::SHA256.hexdigest(mensaje)
					if hash_real == hash_mensaje
						valido = true
					else
						valido = false
						http = 400
						texto = "casi todo bien"
					end
				else
					if http != 400
						http = 500
						valido = false
						texto= "Valores Viciados"
					end
				end


				render json: {:valido => valido, :mensaje => mensaje, :http => http, :texto => texto}
				puts "Hola"
				puts hash_mensaje
				puts hash_real
			end



		  	def status
		  		def to_format
			      controller.response.status = 201

			      put "HOLAAA"

			    end
			    self.responder = ApplicationController
			    render json: {:status => :created}

		  	end


		  	def password_correct?
			  user.hashed_password == Digest::SHA2.hexdigest(user.salt + password_to_confirm)
			end

		


		end
end