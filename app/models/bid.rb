class Bid < ActiveRecord::Base
  belongs_to :auction

  validates :bid_price, presence: true, numericality: { greater_than: 0 }, uniqueness: { scope: :auction_id, message: "A bid of equal value already exists." }

end
