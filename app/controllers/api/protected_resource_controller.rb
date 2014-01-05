module Api
	class Api::ProtectedResourceController < Api::BaseController
		include TokenAuthenticatableHandler
	end
end