class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.find_by like_params

    if @like
      is_success = !!destroy_like(@like)
    else
      is_success = !!Like.create(like_params)
    end

    respond_to do |format|
      format.json do
        render json: {
          is_success: is_success,
          is_new_like: !@like
        }
      end
    end
  end

  private
  def like_params
    params.require(:like).permit :user_id, :activity_id
  end

  def destroy_like like
    like.destroy
  end
end
