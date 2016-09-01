class UserBooksController < ApplicationController
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
    @user_books = @book.user_books.find_by(user_id: params[:user_id])
    if @user_books.update_attribute(:rating, params[:rating])
      book_average_rating = @user_books.average_rating params[:rating]
      respond_to do |format|
        format.json do
          render json: {
            success: "success",
            book_average_rating: book_average_rating
          }
        end
      end
    else
      format.json do
        render json: {
          fail: "fail"
        }
      end
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "books.book_infomation.not_found"
      redirect_to root_url
    end
  end
end
