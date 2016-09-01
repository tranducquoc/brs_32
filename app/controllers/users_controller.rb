class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.page(params[:page]).per(Settings.per_page)
      .has_name(params[:search])
  end

  def show
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "users.not_found"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
