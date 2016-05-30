class AuctionsController < ApplicationController

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    auction_params = params.require(:auction).permit(:title, :details, :end_date, :reserve_price)
    @auction = Auction.create(auction_params)

    if @auction.save
      redirect_to auction_path(@auction), notice: "Auction created."
    else
      flash[:alert] = "Invalid parameters. Auction not created."
      render :new
    end
  end

  def show
    @auction = Auction.find params["id"]
    @bid = Bid.new
    @ordered_bids = @auction.bids.order("bid_price DESC")
  end

end
