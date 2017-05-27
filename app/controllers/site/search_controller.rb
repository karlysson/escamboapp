class Site::SearchController < SiteController

  def ads
    @categories = Category.all
    @ads = Ad.search(params[:q], params[:page])
  end
end
