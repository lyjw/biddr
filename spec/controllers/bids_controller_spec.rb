require 'rails_helper'

RSpec.describe BidsController, type: :controller do

    describe "#create" do

      let(:auction) { FactoryGirl.create(:auction) }

        context "with valid parameters" do

          def valid_bid
            post :create, auction_id: auction.id, bid: { bid_price: 100, auction_id: auction.id }
          end

          it "adds a new bid to the database" do
            count_before = auction.bids.count
            valid_bid
            count_after = auction.bids.count

            expect(count_after).to eq(count_before + 1)
          end

          it "associates the bid with the auction" do
            valid_bid
            expect(Bid.last.auction_id).to eq(auction.id)
          end
        end

      context "with invalid parameters" do

        def invalid_bid
          post :create, auction_id: auction.id, bid: { bid_price: 0, auction_id: auction.id }
        end

        it "renders the auction show page" do
          invalid_bid
          expect(response).to render_template("auctions/show")
        end
      end
    end
end
