class AttachmentsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@attachments = Attachment.includes(:attachable).order("attachable_id").all
		@workshops = @attachments.select{ |a| a.attachable_type == "Workshop" }.group_by{ |id| id[:attachable_id] }
		@plenaries = @attachments.select{ |a| a.attachable_type == "Plenary" }.group_by{ |id| id[:attachable_id] }
		@pages = @attachments.select{ |a| a.attachable_type == "Page" }.group_by{ |id| id[:attachable_id] }
	end

	def destroy
		@attachment = Attachment.find(params[:id])
		@attachment.destroy
		@attachment.pic.clear
	end

end
