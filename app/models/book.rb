class Book < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

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

  def is_favorite_of_user? user
    user.user_books.favorited&.map(&:book_id)&.include? id
  end

  def is_reading_of_user? user
    user.user_books.by_book_id(id).status == Settings.user_book_status.reading
  end

  def is_read_of_user? user
    user.user_books.by_book_id(id).status == Settings.user_book_status.read
  end

  def next_status_of_user user, target_status
    source_status = user.user_books.by_book_id(id).status

    if source_status == target_status
      Settings.user_book_status.no_status
    else
      target_status
    end
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
