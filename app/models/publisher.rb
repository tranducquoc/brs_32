class Publisher < ActiveRecord::Base
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: {minimum:6, maximum: 100}
  validates :address, presence: true, length: {maximum: 255}
end
