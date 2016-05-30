class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :bid_price, presence: true, numericality: { greater_than: 0 }, uniqueness: { scope: :auction_id, message: "A bid of equal value already exists." }

  def bidder
    user ? User.find(user_id).full_name : "Anonymous"
  end
end
