class BooksController < ApplicationController
  def index
    @books = Book.paginate page: params[:page],
      per_page: Settings.per_page
    @categories = Category.all
    @authors = Author.all
    @languages = Language.all
    @publishers = Publisher.all
  end
end
