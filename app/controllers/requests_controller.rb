class RequestsController < ApplicationController
  load_and_authorize_resource params_method: :request_params
  def new
  end

  def create
    if @request.save
      respond_to do |format|
        format.json do
          render json: {
            is_success: true
          }
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: {
            is_success: false
          }
        end
      end
    end
  end

  private
  def request_params
    params.require(:request).permit(:user_id, :book_id)
  end
end
