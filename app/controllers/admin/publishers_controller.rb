class Admin::PublishersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index

  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = I18n.t "admin.publishers.new.flash.success_create"
      redirect_to admin_publishers_path
    else
      flash[:error] = I18n.t "admin.publishers.new.flash.error_create"
      render :new
    end
  end

  private
  def publisher_params
    params.require(:publisher).permit :name, :address, :phone_number
  end
end
