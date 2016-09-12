require "rails_helper"
require "spec_helper"
RSpec.describe "books/show", type: :view do

  describe "books/show.html.erb" do
    before do
      assign :book, FactoryGirl.create(:book)
      sign_in FactoryGirl.create(:user)
      render
    end

    describe "UI book index page" do

      context "title book" do
        it {expect(rendered).to have_text book.title}
      end

      context "price book" do
        it {expect(rendered).to have_text book.price}
      end

      context "should have link Category" do
        it {expect(rendered).to have_text book.publish_date}
      end

      context "button Request" do
        it {expect(rendered).to have_button "Request"}
      end

      context "rating book" do
        it {expect(rendered).to have_xpath("//i[@class = 'glyphicon glyphicon-star']", count: 5)}
      end

      context "Link to review" do
        it {expect(rendered).to have_link "Review"}
      end

      context "button Continue" do
        it {expect(rendered).to have_button "Continue"}
      end
    end
  end
end
