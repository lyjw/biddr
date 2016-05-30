class Auction < ActiveRecord::Base
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :reserve_price, presence: true
end
