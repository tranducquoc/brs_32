class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, only: :show

  def index
    params[:books_filter] ||= Settings.books_filter[:category]
    @search = Book.send(params[:books_filter], params[params[:books_filter]])
      .ransack(params[:q])
    @books = @search.result
      .joins(:category, :author, :publisher, :language)
      .page(params[:page]).per(Settings.per_page)
    @categories = Category.all
    @authors = Author.all
    @languages = Language.all
    @publishers = Publisher.all
  end

  def show
    unless @book
      flash[:danger] = t "books.book_infomation.not_found"
      redirect_to books_path
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
