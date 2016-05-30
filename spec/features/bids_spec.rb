require 'rails_helper'

RSpec.feature "Bids", type: :feature do

  let(:user)    { FactoryGirl.create(:user) }
  let(:auction) { FactoryGirl.create(:auction) }
  before { login_with_web(user) }

  describe "with valid data" do

    it "updates the Auction's current price" do
      visit auction_path(auction)

      valid_bid = { bid_price: "800" }

      fill_in "Bid price", with: valid_bid[:bid_price]

      click_button "Bid"

      expect(current_path).to eq(auction_path(auction))
      expect(auction.currenct_price).to eq(valid_bid[:bid_price])
      expect(page).to have_text ("Current Price: $#{valid_bid[:bid_price]}")
    end

  end

  describe "with invalid data" do
    # it "stays on the new auction page and displays an error message" do
    #   visit new_auction_path
    #
    #   click_button "Save"
    #
    #   expect(current_path).to eq(new_auction_path)
    #   expect(page).to have_text /can't be blank/i
    # end
  end

end
