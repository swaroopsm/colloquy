class UsersController < ApplicationController
	before_filter :getallextras


	private
  def getallextras
  	@xpage = Page.select([:title, :pagecat_id])
  	@xpagecats = Pagecat.all
  end
end
