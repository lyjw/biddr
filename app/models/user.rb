class User < ActiveRecord::Base
  has_secure_password

  has_many :bids, dependent: :destroy
  has_many :auctions, dependent: :nullify

  validates_presence_of :first_name, :last_name

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end
end
