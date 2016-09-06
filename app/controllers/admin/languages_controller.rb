class Admin::LanguagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index

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

  private
  def language_params
    params.require(:language).permit :name
  end
end
