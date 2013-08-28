class IdeasController < ApplicationController

	before_filter :authenticate_user!, :except => [:index. :show]
	load_and_authorize_resource :board, :except => [:index, :show]
	load_and_authorize_resource	:idea, :except => [:index, :show], :through => :board

end
