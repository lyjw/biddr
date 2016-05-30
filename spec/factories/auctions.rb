FactoryGirl.define do
  factory :auction do
    title           { Faker::Company.name }
    details        { Faker::Hipster.paragraph }
    end_date      { Faker::Date.between(Date.today, 3.weeks.from_now) }
    reserve_price { 1000 }
  end
end
