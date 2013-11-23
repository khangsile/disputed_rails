include ApiHelper
class Api::SessionsController < Api::ProtectedResourceController
	before_filter(only: :destroy) { render_unauthorized if current_user.nil? }

	# If valid login, create an authentication token for subsequent requests
	# Otherwise, render invalid login attempt
	def create
		resource = User.find_for_database_authentication(email: params.require(:email).downcase)
		
		if resource && resource.valid_password?(params.require(:password))
			resource.ensure_authentication_token!					
			@user = resource
		else
			render_invalid_login
		end
	end

	def facebook_login
		# token = JSON.parse(request.env['omniauth_token']);
		# token = fb[:credentials][:token]
				logger.debug request.headers['OAUTH']
		fb_user = FbGraph::User.me(request.headers['OAUTH'])

		logger.debug fb_user.to_yaml
		if user
			# @user = User.find_by(email: fb_user.email)
			# @user.ensure_authentication_token!
		end
	end

	# Destroy the session by resetting the user's authentication token
	def destroy
		current_user.reset_authentication_token!
		render_success
	end
end


