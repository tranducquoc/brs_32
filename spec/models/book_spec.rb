require "rails_helper"
require "database_cleaner"

describe Book do
  describe "validation" do
    subject {FactoryGirl.create :book}

    describe "title" do
      context "not valid when title nil" do
        before {subject.title = nil}
        it {expect(subject).to have(2).error_on(:title)}
      end

      context "not valid when title length less than 10 characters" do
        before {subject.title = Faker::Lorem.characters(9)}
        it {expect(subject).to have(1).error_on(:title)}
      end

      context "not valid when title length greater than 100 characters" do
        before {subject.title = Faker::Lorem.characters(101)}
        it {expect(subject).to have(1).error_on(:title)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:title)}
      end
    end

    describe "description" do
      context "not valid when description nil" do
        before {subject.description = nil}
        it {expect(subject).to have(2).error_on(:description)}
      end

      context "not valid when description length less than 10 characters" do
        before {subject.description = Faker::Lorem.characters(9)}
        it {expect(subject).to have(1).error_on(:description)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:description)}
      end
    end

    describe "publish_date" do
      context "not valid when publish_date nil" do
        before {subject.publish_date = nil}
        it {expect(subject).to have(1).error_on(:publish_date)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:publish_date)}
      end
    end
    describe "author" do
      context "not valid when author nil" do
        before {subject.author = nil}
        it {expect(subject).to have(1).error_on(:author)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:author)}
      end
    end

    describe "category" do
      context "not valid when category nil" do
        before {subject.category = nil}
        it {expect(subject).to have(1).error_on(:category)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:author)}
      end
    end

    describe "publisher" do
      context "not valid when publisher nil" do
        before {subject.publisher = nil}
        it {expect(subject).to have(1).error_on(:publisher)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:publisher)}
      end
    end

    describe "language" do
      context "not valid when language nil" do
        before {subject.language = nil}
        it {expect(subject).to have(1).error_on(:language)}
      end

      context "valid" do
        it {expect(subject).to have(0).error_on(:language)}
      end
    end
  end

  describe "validation function" do
    describe "#is_favorite_of_user?" do
      context "should be true when user favorite book" do
        user_favorite_books = FactoryGirl.create(:user_favorite_books)
        first_favorite = user_favorite_books.user_books.first
        book = first_favorite.book
        it {expect(book.is_favorite_of_user? user_favorite_books).to be true}
      end

      context "should be false when user not favorite book" do
        user_favorite_books = FactoryGirl.create(:user_favorite_books)
        it {expect(subject.is_favorite_of_user? user_favorite_books).to be false}
      end
    end

    describe "#is_reading_of_user?" do
      context "should be true when user is reading book" do
        user_reading_books = FactoryGirl.create(:user_reading_books)
        first_reading = user_reading_books.user_books.first
        book = first_reading.book
        it {expect(book.is_reading_of_user? user_reading_books).to be true}
      end

      context "should be false when user not reading book" do
        user_reading_books = FactoryGirl.create(:user_reading_books)
        it {expect(subject.is_reading_of_user? user_reading_books).to be false}
      end
    end

    describe "#is_read_of_user?" do
      context "should be true when user is read book" do
        user_read_books = FactoryGirl.create(:user_read_books)
        first_reading = user_read_books.user_books.first
        book = first_reading.book
        it {expect(book.is_read_of_user? user_read_books).to be true}
      end

      context "should be false when user not read book" do
        user_read_books = FactoryGirl.create(:user_read_books)
        it {expect(subject.is_read_of_user? user_read_books).to be false}
      end
    end

    describe "#next_status_of_user user, target_status" do
      context "should be return target_status when source_status not equal target_status" do
        user_read_books = FactoryGirl.create(:user_read_books)
        first_read = user_read_books.user_books.first
        book = first_read.book
        it {expect(book
          .next_status_of_user user_read_books, Settings.user_book_status.reading)
          .to eq(Settings.user_book_status.reading)}
      end

      context "should be return no_status when source_status equal target_status" do
        user_read_books = FactoryGirl.create(:user_read_books)
        first_read = user_read_books.user_books.first
        book = first_read.book
        it {expect(book
          .next_status_of_user user_read_books, Settings.user_book_status.read)
          .to eq(Settings.user_book_status.no_status)}
      end

      context "should be return target_status when source_status nil" do
        user_read_books = FactoryGirl.create(:user_read_books)
        book = FactoryGirl.create(:book)
        it {expect(book
          .next_status_of_user user_read_books, Settings.user_book_status.reading)
          .to eq(Settings.user_book_status.reading)}
      end
    end
  end

  describe "validation scope" do
    describe ".of_category" do
      context "should be include book if category contain book" do
        book = FactoryGirl.create(:book)
        category = book.category
        it {expect(Book.of_category category.id).to include(book)}
      end

      context "should not be include book if category not contain book" do
        book = FactoryGirl.create(:book)
        category = FactoryGirl.create(:category)
        it {expect(Book.of_category category.id).not_to include(book)}
      end
    end

    describe ".of_author" do
      context "should be include book if book of author" do
        book = FactoryGirl.create(:book)
        author = book.author
        it {expect(Book.of_author author.id).to include(book)}
      end

      context "should not be include book if book not of author" do
        book = FactoryGirl.create(:book)
        author = FactoryGirl.create(:author)
        it {expect(Book.of_author author.id).not_to include(book)}
      end
    end

    describe ".of_publisher" do
      context "should be include book if book of author" do
        book = FactoryGirl.create(:book)
        publisher = book.publisher
        it {expect(Book.of_publisher publisher.id).to include(book)}
      end

      context "should not be include book if book not of author" do
        book = FactoryGirl.create(:book)
        publisher = FactoryGirl.create(:publisher)
        it {expect(Book.of_publisher publisher.id).not_to include(book)}
      end
    end

    describe ".of_language" do
      context "should be include book if book of author" do
        book = FactoryGirl.create(:book)
        language = book.language
        it {expect(Book.of_language language.id).to include(book)}
      end

      context "should not be include book if book not of author" do
        book = FactoryGirl.create(:book)
        language = FactoryGirl.create(:language)
        it {expect(Book.of_language language.id).not_to include(book)}
      end
    end
  end
end
