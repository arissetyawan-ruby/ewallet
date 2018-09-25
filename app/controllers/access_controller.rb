class AccessController < ApplicationController
	layout 'logged'
	before_action :authenticate_user!

end
