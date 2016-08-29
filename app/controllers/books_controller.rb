class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    params[:books_filter] ||= Settings.books_filter[:category]
    @books = Book.send(params[:books_filter], params[params[:books_filter]])
      .paginate(page: params[:page], per_page: Settings.per_page)
    @categories = Category.all
    @authors = Author.all
    @languages = Language.all
    @publishers = Publisher.all
  end
end
