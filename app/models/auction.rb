class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :reserve_price, presence: true

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :reserve_won
    state :reserve_not_met
    state :unpublished

    event :publish do
      transitions from: :draft, to: :published
    end

    event :auction_ends_with_reserve_met do
      transitions from: :published, to: :reserve_met
    end

    event :auction_ends_with_winning_bid do
      transitions from: :reserve_met, to: :reserve_won
    end

    event :auction_ends_reserve_not_met do
      transitions from: :published, to: :reserve_not_met
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end
end
