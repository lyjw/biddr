class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    auction_params = params.require(:auction).permit(:title, :details, :end_date, :reserve_price)
    @auction = Auction.create(auction_params)
    @auction.user = current_user

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

  def publish
    @auction = Auction.find params["auction_id"]
    @auction.publish
    @auction.save
    redirect_to auction_path(@auction)
  end

  def unpublish
    @auction = Auction.find params["auction_id"]
    @auction.unpublish
    @auction.save
    redirect_to auction_path(@auction)
  end
end
