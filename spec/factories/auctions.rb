FactoryGirl.define do
  factory :auction do
    title           { "Vintage Wardrobe from the Renaissance Period" }
    details        { "A beautiful piece that would look stunning in a house of any era"}
    end_date      { Date.today + 1.week }
    reserve_price { 5000 }
  end
end
