RSpec.describe Auction, type: :model do

  describe "validations" do
    
    it "requires a title" do
      a = Auction.new FactoryGirl.attributes_for(:auction, title: nil)
      expect(a).to be_invalid
    end

    it "requires a reserve price" do
      a = Auction.new FactoryGirl.attributes_for(:auction, reserve_price: nil)
      expect(a).to be_invalid
    end

  end

end
