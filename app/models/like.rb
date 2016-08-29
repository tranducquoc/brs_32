class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  validates :user, presence: true
  validates :activity, presence: true

  scope :by_activity, -> activity_id do
    where activity_id: activity_id
  end
end
