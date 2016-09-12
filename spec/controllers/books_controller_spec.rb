require "rails_helper"

RSpec.describe BooksController, type: :controller do

  before {sign_in FactoryGirl.create(:user)}

  describe "GET index" do
    let(:books) {FactoryGirl.create_list(:book,10)}
    let(:categories) {FactoryGirl.create_list(:category, 2)}
    let(:authors) {FactoryGirl.create_list(:author, 2)}
    let(:publishers) {FactoryGirl.create_list(:publisher, 2)}
    let(:languages) {FactoryGirl.create_list(:language, 2)}
    it "should response a 200 status code at first time visit" do
      get :index
      expect(response.status).to eq 200
    end

    it "should render index if have params book filter" do
      get :index, {books_filter: Settings.books_filter[:category]}
      expect(response).to render_template(:index)
    end

    it "should render index with book have title same as user search" do
      get :index, {q: {title_or_category_name_or_author_name_or_publisher_name_or_language_name_cont:
        "#{books.first.title}"}}
      expect(assigns(:books).first.title).to eq books.first.title
    end

    it "should render index with book have category same as user search" do
      get :index, {q: {title_or_category_name_or_author_name_or_publisher_name_or_language_name_cont:
        "#{books.first.category.name}"}}
      expect(assigns(:books).first.category.name).to eq categories.first.name
    end

    it "should render index with book have author same as user search" do
      get :index, {q: {title_or_category_name_or_author_name_or_publisher_name_or_language_name_cont:
        "#{books.first.author.name}"}}
      expect(assigns(:books).first.author.name).to eq authors.first.name
    end

    it "should render index with book have publisher same as user search" do
      get :index, {q: {title_or_category_name_or_author_name_or_publisher_name_or_language_name_cont:
        "#{books.first.publisher.name}"}}
      expect(assigns(:books).first.publisher.name).to eq publishers.first.name
    end

    it "should render index with book have language same as user search" do
      get :index, {q: {title_or_category_name_or_author_name_or_publisher_name_or_language_name_cont:
        "#{books.first.language.name}"}}
      expect(assigns(:books).first.language.name).to eq languages.first.name
    end
  end

  describe "GET show" do
    let(:books) {FactoryGirl.create_list(:book, 10)}

    it "should be show book if book not nil" do
      get :show, {id: "#{books.first.id}"}
      expect(assigns(:book).id).to eq books.first.id
    end

    it "should be redirect to root_url if book nil" do
      get :show, {id: "#{books.last.id + 1}"}
      expect(response).to redirect_to books_path
    end
  end
end
