require "rails_helper"

describe User do
  before(:each) do
    @user = create(:user)
  end

  describe "validations" do
    describe "name validations" do
      it "should have a name" do
        @user.name = nil
        expect(@user).to_not be_valid
      end

      it "should allow name length between 1 and 100" do
        @user.name = "a"
        expect(@user).to be_valid

        @user.name = "a" * 100
        expect(@user).to be_valid
      end

      it "should not allow name longer than 100" do
        @user.name = "a" * 101
        expect(@user).to_not be_valid
      end
    end

    describe "email validations" do
      it "should have an email" do
        @user.email = nil
        expect(@user).to_not be_valid
      end

      it "should allow email length between 5 and 100" do
        @user.email = "a@b.c"
        expect(@user).to be_valid

        @user.email = "a" * (100 - "@gmail.com".length) + "@gmail.com"
        expect(@user).to be_valid
      end

      it "should allow a valid email" do
        @user.email = "test_123@gmail.com"
        expect(@user).to be_valid
      end

      it "should not allow email longer than 100" do
        @user.email = "a" * (101 - "@gmail.com".length) + "@gmail.com"
        expect(@user).to_not be_valid
      end

      it "should not allow email without domain" do
        @user.email = "email"
        expect(@user).to_not be_valid
      end

      it "should not allow email with an invalid domain" do
        @user.email = "email@test."
        expect(@user).to_not be_valid
      end

      it "should not allow email with space" do
        @user.email = "e mail@test.com"
        expect(@user).to_not be_valid
      end

      it "should not allow email with special characters" do
        @user.email = "e#mail@test.com"
        expect(@user).to_not be_valid
      end
    end

    describe "password validations" do
      it "should have a password" do
        @user.password = nil
        expect(@user).to_not be_valid
      end

      it "should allow a valid password" do
        @user.password = "A123@a123"
        expect(@user).to be_valid
      end

      it "should not allow a too long password" do
        @user.password = "a" * 999
        expect(@user).to_not be_valid
      end

      it "should not allow password less than 6" do
        @user.password = "12345"
        expect(@user).to_not be_valid
      end
    end
  end

  describe "functions" do
    context ".is_user?" do
      it "should be true if the user is the same as the passed user" do
        new_user = User.find_by id: @user.id
        expect(@user.is_user? new_user).to be true
      end

      it "should be false if the user is not the passed user" do
        new_user = create(:other_user)
        expect(@user.is_user? new_user).to be false
      end
    end

    context ".is_admin?" do
      it "should be true if the user role is 0" do
        admin = create(:admin)
        expect(admin.is_admin?).to be true
      end

      it "should be false if the user role is not 0" do
        expect(@user.is_admin?).to be false
      end
    end

    context ".has_requested" do
      it "should be true if user has requested the passed book" do
        user_with_requests = create(:user_with_requests)
        one_requested_book = user_with_requests.requests.first

        expect(user_with_requests.has_requested one_requested_book.book_id)
          .to be true
      end

      it "should be false if user has not requested the passed book" do
        one_arbitrary_book = Book.new

        expect(@user.has_requested one_arbitrary_book.id)
          .to be false
      end
    end

    context ".follow" do
      it "should be able to follow other user" do
        other_user = create(:other_user)
        @user.follow other_user

        expect(@user.active_relationships.find_by(followed_id: other_user.id)
          .followed_id).to eq other_user.id
      end
    end

    context ".unfollow" do
      it "should be able to unfollow other user" do
        other_user = create(:other_user)
        @user.follow other_user
        @user.unfollow other_user

        expect(@user.active_relationships.find_by followed_id: other_user.id)
          .to be_nil
      end
    end

    context ".following?" do
      it "should be true if user is following the passed user" do
        other_user = create(:other_user)
        @user.follow other_user

        expect(@user.following? other_user).to be true
      end

      it "should be false if user is not following the passed user" do
        other_user = create(:other_user)

        expect(@user.following? other_user).to be false
      end
    end
  end
end
