class Admin::PublishersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @search = Publisher.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @publishers = @search.result
      .page(params[:page]).per(Settings.per_page)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
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

  def edit
  end

  def update
    if @publisher.update(publisher_params)
      flash[:success] = I18n.t "admin.publishers.edit.success"
      redirect_to admin_publishers_path
    else
      flash[:danger] = I18n.t "admin.publishers.edit.failed"
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = I18n.t "admin.publishers.destroy.success"
    else
      flash[:danger] = I18n.t "admin.publishers.destroy.failed"
    end
    redirect_to admin_publishers_path
  end

  private
  def publisher_params
    params.require(:publisher).permit :name, :address, :phone_number
  end
end
