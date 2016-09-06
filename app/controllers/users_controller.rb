class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.page(params[:page]).per(Settings.per_page)
      .has_name(params[:search])
  end

  def show
    @favorite_books = @user.user_books.favorited
    @reading_history_books = @user.user_books.reading_history
  end

  private
  def load_user
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
