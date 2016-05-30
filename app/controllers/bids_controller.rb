class BidsController < ApplicationController

  def create
    @auction = Auction.find params["auction_id"]
    bid_params = params.require(:bid).permit([:bid_price])
    @bid = Bid.new(bid_params)
    @bid.auction = @auction

    if @bid.save
      redirect_to auction_path(@auction), notice: "Bid created."
    else
      flash[:alert] = "Bid not created."
      render "auctions/show"
    end
  end

end
