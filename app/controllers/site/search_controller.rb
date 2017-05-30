class Site::SearchController < SiteController

  def ads
    cookies[:search_term] =  params[:q]
    @categories = Category.all
    @ads = Ad.search(params[:q], fields: [:title],
                            page: params[:page], per_page: Ad::QTD_PER_PAGE)
    cookies[:categories] = @categories.to_json
  end
end
