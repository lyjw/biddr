require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

    let(:auction) { FactoryGirl.create(:auction) }
    let(:user) { FactoryGirl.create(:user) }

    before { login(user) }

    describe "#new" do
      before { get :new }

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "assigns a auction to an instance variable" do
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end

    describe "#create" do

      context "given valid parameters" do

        def valid_request
          post :create, auction: FactoryGirl.attributes_for(:auction)
        end

        it "adds a new record to the Product database" do
          count_before = Auction.count
          valid_request
          count_after = Auction.count

          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the show template" do
          valid_request
          expect(response).to redirect_to(auction_path(Auction.last))
        end
      end

      context "given invalid parameters" do

        def invalid_request
          post :create, auction: {title: ""}
        end

        it "does not add a record to the Auction database" do
          count_before = Auction.count
          invalid_request
          count_after = Auction.count

          expect(count_after).to eq(count_before)
        end

        it "redirects to the new template" do
          invalid_request
          expect(response).to render_template :new
        end
      end
    end

end
