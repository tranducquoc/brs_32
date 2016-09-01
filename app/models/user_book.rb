class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  validates :user, presence: true
  validates :book, presence: true

  scope :favorited, -> do
    where is_favorite: true
  end

  scope :reading_history, -> do
    read_reading_status = "#{Settings.user_book_status.reading},
      #{Settings.user_book_status.read}"
    where "status IN (#{read_reading_status})"
  end
end
