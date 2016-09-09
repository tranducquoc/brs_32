require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "Associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :activity}
  end

  describe "Validations" do
    it {is_expected.to validate_presence_of :user}
    it {is_expected.to validate_presence_of :activity}
  end
end
