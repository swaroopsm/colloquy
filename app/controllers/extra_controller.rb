class ExtraController < ApplicationController
	



	private
	def getallextras
  	@xpagecategories = Pagecat.all
  end

  def getpagecategories
  	@xpagecategories = Pagecat.all
  end
end