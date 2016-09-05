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

  scope :current_user_rating, -> user_id {find_by user_id: user_id}

  after_update :update_book

  def average_rating user_rating
    total_rating = self.book.user_books.count
    book_average_rating =
      (self.book.average_rating * total_rating + user_rating.to_f)/(total_rating+1)
  end

  private

  def update_book
    book_average_rating = average_rating self.rating
    self.book.update average_rating: book_average_rating
  end
end
