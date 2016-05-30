class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :bid_price, presence: true, uniqueness: { scope: :auction_id, message: "A bid of equal value already exists." }

  # validate :bid_price_is_greater_than_current_highest_bid

  validates_numericality_of :bid_price, :greater_than => Proc.new { |r| r.highest_bid_in_auction }

  def bidder
    user ? User.find(user_id).full_name : "Anonymous"
  end

  def for_auction
    Auction.find(auction_id).title
  end
  
  # def bid_price_is_greater_than_current_highest_bid
  #   current_highest_bid = Bid.all.where("auction_id = ?", auction_id).order("bid_price DESC").first.bid_price || 0
  #
  #   if bid_price < current_highest_bid
  #     errors.add(:bid_price, "Bid must be higher than current price!")
  #   end
  # end

  def highest_bid_in_auction
    Bid.all.where("auction_id = ?", auction_id).order("bid_price DESC").first.bid_price || 0.00
  end
end
