class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: [:edit, :update]

  def create
    @category = CategoryService.create(params_category)

    unless @category.errors.any?
      redirect_to backoffice_categories_path, notice: "A Categoria(#{@category.description}) foi Cadastrada com Sucesso."
    else
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update

    if @category.update(params_category)
      redirect_to backoffice_categories_path, notice: "A Categoria(#{@category.description}) foi Atualizada com Sucesso."
    else
      render :edit
    end
  end

  def set_category
    @category = Category.friendly.find(params[:id])
  end

private
  def params_category
    params.require(:category).permit(:description)
  end
end
