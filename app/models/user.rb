class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook,:google_oauth2,:twitter]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_books, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  enum role: {user: 1, admin: 0}
  validates :email, presence: true, length: {maximum: 100},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 100}
  validates :password, presence: true, length: {minimum: 6}
  scope :has_name, ->(keyword) {where("name LIKE ?", "%#{keyword}%")}

  def is_user? current_user
    current_user == self
  end

  def is_admin?
    role == Settings.role[:admin]
  end

  def has_requested book_id
    !self.requests.find_by(book_id: book_id).nil?
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.id).first_or_create do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
