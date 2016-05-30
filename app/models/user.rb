class User < ActiveRecord::Base
  has_secure_password

  has_many :bids, dependent: :destroy
  has_many :auctions, dependent: :nullify

  validates_presence_of :first_name, :last_name

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
