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

    service = Auctions::CreateAuction.new(user: current_user, params: auction_params)

    if service.call
      redirect_to auction_path(service.auction), notice: "Auction created."
    else
      flash[:alert] = "Invalid parameters. Auction not created."
      @auction = service.auction
      render :new
    end
  end

  def show
    @auction = Auction.find params["id"]
    @bid = Bid.new
    @ordered_bids = @auction.bids.order("bid_price DESC")
  end

  def publish
    auction = Auction.find params["auction_id"]
    service = Auctions::PublishAuction.new(auction: auction)

    if service.call
      redirect_to auction_path(service.auction)
    end
  end

  def unpublish
    auction = Auction.find params["auction_id"]
    service = Auctions::UnpublishAuction.new(auction: auction)

    if service.call
      redirect_to auction_path(service.auction)
    end
  end
end
