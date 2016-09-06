class Admin::AuthorsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index

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

  private
  def author_params
    params.require(:author).permit :name
  end
end
