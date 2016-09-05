class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  load_and_authorize_resource

  def index
  end

  def new
    @category = Category.new
  end

  def create
    if @category.save
      flash[:success] = I18n.t "admin.categories.new.create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = I18n.t "admin.categories.new.create_failed"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
