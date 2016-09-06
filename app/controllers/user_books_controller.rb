class UserBooksController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_book, only: [:create, :show, :update]

  def new
  end

  def create
    unless current_user.find_by(id: @book.id).user_books&.review
      current_user.user_books.create book: @book, review: params[:review]
    end
    redirect_to books_path
  end

  def show
    @user_books = @book.user_books
  end

  def update
    user_book = @book.user_books.find_by(user_id: user_book_params[:user_id],
                                         book_id: user_book_params[:book_id])
    user_book ||= @book.user_books.new user_id: user_book_params[:user_id]

    if user_book.update_attributes user_book_params
      json_response = {
        success: true
      }

      if user_book_params[:is_favorite]
        json_response[:is_favorite] = user_book_params[:is_favorite] == "true"
      end

      if user_book_params[:rating]
        json_response[:book_average_rating] = user_book
          .average_rating user_book_params[:rating]
      end

      respond_to do |format|
        format.json do
          render json: json_response
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: {
            success: false
          }
        end
      end
    end
  end

  private
  def user_book_params
    params.require(:user_book).permit :user_id, :book_id, :status,
                                      :is_favorite, :rating, :review
  end

  def load_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "books.book_infomation.not_found"
      redirect_to root_url
    end
  end
end
