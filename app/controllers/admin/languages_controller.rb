class Admin::LanguagesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @search = Language.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
     @languages = @search.result
      .page(params[:page]).per(Settings.per_page)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new language_params
    if @language.save
      flash[:success] = I18n.t "admin.languages.new.flash.success_create"
      redirect_to admin_languages_path
    else
      flash[:error] = I18n.t "admin.languages.new.flash.error_create"
      render :new
    end
  end

  def edit
  end

  def update
    if @language.update(language_params)
      flash[:success] = I18n.t "admin.languages.edit.success"
      redirect_to admin_languages_path
    else
      flash[:danger] = I18n.t "admin.languages.edit.failed"
      render :edit
    end
  end

  def destroy
    if @language.destroy
      flash[:success] = I18n.t "admin.languages.destroy.success"
    else
      flash[:danger] = I18n.t "admin.languages.destroy.failed"
    end
    redirect_to admin_languages_path
  end

  private
  def language_params
    params.require(:language).permit :name
  end
end
