require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let!(:user) {FactoryGirl.create :user}
  before {sign_in user}
  let!(:book) {FactoryGirl.create :book}
  let!(:user_book) {FactoryGirl.create :user_book}

  let :attr_true do
    FactoryGirl.attributes_for :comment, user_id: user.id, user_book_id: user_book.id, content: "aaa"
  end

  let :attr_false do
    FactoryGirl.attributes_for :comment, user_id: nil, user_book_id: nil, content: nil
  end

  describe "#new" do
    it do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#create" do

    it "crete success" do
      post :create, comment: attr_true
      expect(assigns(:comment)).to be_a Comment
    end

    it "create fail" do
      post :create, comment: attr_false
      expect(response).to render_template :new
    end
  end

  describe "#destroy" do
    let(:comment) {FactoryGirl.create :comment}

    it "success" do
      delete :destroy, id: comment.id
      expect(flash[:success]).to be_present
    end

    it "fail" do
      delete :destroy, id: 0
      expect(flash[:danger]).to be_present
    end
  end
end
