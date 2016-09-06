class Admin::AuthorsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @search = Author.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @authors = @search.result
      .page(params[:page]).per(Settings.per_page)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = I18n.t "admin.authors.new.flash.success_create"
      redirect_to admin_authors_path
    else
      flash[:error] = I18n.t "admin.authors.new.flash.error_create"
      render :new
    end
  end

  def edit
  end

  def update
    if @author.update(author_params)
      flash[:success] = I18n.t "admin.authors.edit.success"
      redirect_to admin_authors_path
    else
      flash[:danger] = I18n.t "admin.authors.edit.failed"
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = I18n.t "admin.authors.destroy.success"
    else
      flash[:danger] = I18n.t "admin.authors.destroy.failed"
    end
    redirect_to admin_authors_path
  end

  private
  def author_params
    params.require(:author).permit :name
  end
end
