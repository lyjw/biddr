class BidsController < ApplicationController

  def create
    @auction = Auction.find params["auction_id"]
    bid_params = params.require(:bid).permit([:bid_price])
    @ordered_bids = @auction.bids.order("bid_price DESC")
    @bid = Bid.new(bid_params)
    @bid.auction = @auction
    @bid.user = current_user

    if @bid.save
      @auction.current_price = @bid.bid_price
      @auction.save
      redirect_to auction_path(@auction), notice: "Bid created."
    else
      flash[:alert] = "Bid not created."
      render "auctions/show"
    end
  end

end
