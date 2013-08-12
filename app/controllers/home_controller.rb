class HomeController < ApplicationController
	
  def index
  	getallextras
  end



  private
  def getallextras
  	@xpage = Page.select([:title, :pagecat_id])
  	@xpagecats = Pagecat.all
  end

end
