class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @user_book = UserBook.find_by id: review_params[:user_book_id]
    @comment = @user_book.comments.build(review_params)

    if @comment.save
      flash.now[:success] = t"commented"
      redirect_to user_book_path @user_book.book
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    if @comment.destroy
      flash[:success] = t"comment.delete"
    else
      flash[:danger] = t"comment.not_delete"
    end
    redirect_to root_url
  end

  private

  def review_params
    params.require(:comment).permit :content, :user_book_id, :user_id
  end
end
