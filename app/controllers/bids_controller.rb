class BidsController < ApplicationController

  def create
    @auction = Auction.find params["auction_id"]
    bid_params = params.require(:bid).permit([:bid_price])
    @ordered_bids = @auction.bids.order("bid_price DESC")
    @bid = Bid.new(bid_params)
    @bid.auction = @auction
    @bid.user = current_user

    respond_to do |format|
      if @bid.save
        @auction.current_price = @bid.bid_price
        @auction.reserve_met if reserve_met?
        @auction.save

        format.html { redirect_to auction_path(@auction), notice: "Bid created." }
        format.js { render :create_success }
      else
        flash[:alert] = "Bid not created."

        format.html { render "auctions/show" }
        format.js { render :create_failure }
      end
    end
  end

  private

  def reserve_met?
    @auction.current_price >= @auction.reserve_price
  end

end
