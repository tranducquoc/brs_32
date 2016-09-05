class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  belongs_to :language
  has_many :user_books, dependent: :destroy
  has_many :requests, dependent: :destroy
  validates :author, presence: true
  validates :category, presence: true
  validates :publisher, presence: true
  validates :language, presence: true
  validates :title, presence: true, length: {minimum: 10, maximum: 100}
  validates :description, presence: true, length: {minimum: 10}
  validates :publish_date, presence: true
  mount_uploader :cover_image_name, BookUploader

  default_scope {order created_at: :desc}

  scope :of_category, -> category_id do
    where category_id: category_id if category_id.present?
  end
  scope :of_author, -> author_id do
    where author_id: author_id if author_id.present?
  end
  scope :of_publisher, -> publisher_id do
    where publisher_id: publisher_id if publisher_id.present?
  end
  scope :of_language, -> language_id do
    where language_id: language_id if language_id.present?
  end

  def is_favorite_of_user user
    user.user_books.favorited&.map(&:book_id)&.include? id
  end
end
