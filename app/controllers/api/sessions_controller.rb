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
			warden.custom_failure!
			render_invalid_login
		end
	end

	def facebook_login
		# token = JSON.parse(request.env['omniauth_token']);
		# token = fb[:credentials][:token]
		logger.debug request.headers['OAUTH']
		fb_user = FbGraph::User.me(request.headers['OAUTH']).fetch
		logger.info fb_user.to_yaml
		render_invalid_login and return if fb_user.blank?
		@user = User.find_by(email: fb_user.email)
		if @user.nil?
			@user = User.create!(fb_params(fb_user))
		end
		@user.ensure_authentication_token!
	end

	# Destroy the session by resetting the user's authentication token
	def destroy
		current_user.reset_authentication_token!
		render_success
	end

	private

	def fb_params(user)
		fb = user.raw_attributes
		hometown = fb[:location] && fb[:location][:name].split(',')
		[first_name: fb[:first_name], last_name: fb[:last_name], email: fb[:email],
			city: hometown && hometown[0].strip, state: hometown && hometown[1].strip, 
			password: Devise.friendly_token[0,20]]
	end


end


