class Comment < ActiveRecord::Base
  belongs_to :user_book
  belongs_to :user
  validates :user_book, presence: true
  validates :user, presence: true
end
