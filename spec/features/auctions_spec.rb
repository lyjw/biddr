require 'rails_helper'

RSpec.feature "Auctions", type: :feature do

  let(:user) { FactoryGirl.create(:user) }
  before { login_with_web(user) }

  describe "with valid data" do

    it "displays a 'Create New Auction' heading on the page and redirects to the Auction show page after creation" do
      visit new_auction_path

      valid_auction = FactoryGirl.attributes_for(:auction)

      fill_in "Title", with: valid_auction[:title]
      fill_in "Details", with: valid_auction[:details]
      fill_in "End Date", with: valid_auction[:end_date]
      fill_in "Reserve Price", with: valid_auction[:reserve_price]

      click_button "Save"

      expect(current_path).to eq(auction_path(Auction.last))
      expect(page).to have_text valid_auction[:title]
    end

  end

  describe "with invalid data" do
    it "stays on the new auction page and displays an error message" do
      visit new_auction_path

      click_button "Save"

      expect(current_path).to eq(new_auction_path)
      expect(page).to have_text /can't be blank/i
    end
  end

end
