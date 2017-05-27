class Site::SearchController < SiteController

  def ads
    cookies[:search_term] =  params[:q]
    @categories = Category.all
    @ads = Ad.search(params[:q], params[:page])
    cookies[:categories] = @categories.to_json
  end
end
