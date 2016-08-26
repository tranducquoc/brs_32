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
end
