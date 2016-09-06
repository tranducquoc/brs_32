class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :user, presence: true
  validates :book, presence: true
  enum status: {waiting: 0, approved: 1, rejected: 2}
  scope :of_user, -> user_id {where user_id: user_id}
end
