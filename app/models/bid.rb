class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :bid_price, presence: true, uniqueness: { scope: :auction_id, message: "A bid of equal value already exists." }

  validates_numericality_of :bid_price, :greater_than => Proc.new { |r| r.highest_bid_in_auction }

  def bidder
    user ? User.find(user_id).full_name : "Anonymous"
  end

  def for_auction
    Auction.find(auction_id).title
  end

  def highest_bid_in_auction
    if Bid.all.where("auction_id = ?", auction_id).length > 0
      Bid.all.where("auction_id = ?", auction_id).order("bid_price DESC").first.bid_price
    else
      0.00
    end
  end
end
