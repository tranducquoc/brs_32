require "rails_helper"

describe Activity, type: :model do
  before(:each) do
    @activity = create(:activity)
  end

  describe "validations" do
    it "should belong to an user" do
      expect(@activity.user).to_not be nil
    end
  end

  describe "functions" do
    context ".likes_count" do
      it "should return the number of likes to the activity" do
        activity_with_likes = create(:activity_with_likes)
        expect(activity_with_likes.likes_count).to eq 5
      end

      it "should return 0 if the passed activity has no like" do
        expect(@activity.likes_count).to eq 0
      end
    end
  end
end
