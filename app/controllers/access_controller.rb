class AccessController < ApplicationController
	layout 'logged'
	before_action :authenticate_account!

end
