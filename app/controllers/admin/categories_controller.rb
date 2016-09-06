class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  load_and_authorize_resource

  def index
    @search = Category.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @categories = @search.result
      .page(params[:page]).per(Settings.per_page)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
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

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = I18n.t "admin.categories.edit.success"
      redirect_to admin_categories_path
    else
      flash[:danger] = I18n.t "admin.categories.edit.failed"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = I18n.t "admin.categories.destroy.success"
    else
      flash[:danger] = I18n.t "admin.categories.destroy.failed"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
