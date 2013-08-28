class IdeasController < ApplicationController

	before_filter :authenticate_user!, :except => [:index, :show]
	before_filter :load_board
	load_and_authorize_resource	:idea, :except => [:index, :show]

	def new
		respond_to do |format|
			format.js
		end
	end

	private
	def load_board
		@board = Board.find(params[:board_id])
	end

end
