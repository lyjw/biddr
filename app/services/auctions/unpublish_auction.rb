class Auctions::UnpublishAuction
  include Virtus.model

  attribute :auction, Auction

  def call
    @auction.unpublish
    @auction.save
  end
end
