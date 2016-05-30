class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :reserve_price, presence: true

  after_initialize :set_current_price_to_zero

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

    event :reserve_met do
      transitions from: :published, to: :reserve_met
    end

    event :reserve_won do
      transitions from: :reserve_met, to: :reserve_won
    end

    event :reserve_not_met do
      transitions from: :published, to: :reserve_not_met
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  def update_current_price
    bids.order("bid_price DESC").first.bid_price
  end

  def set_current_price_to_zero
    current_price = 0
  end
end
