class Language < ActiveRecord::Base
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: {maximum: 30}
end
