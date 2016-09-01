class Admin::RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @requests = Request.page(params[:page]).per(Settings.per_page)
  end

end
