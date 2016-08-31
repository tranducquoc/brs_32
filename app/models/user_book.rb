class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  validates :user, presence: true
  validates :book, presence: true

  scope :favorited, -> do
    where :is_favorite
    order created_at: :desc
  end
end
