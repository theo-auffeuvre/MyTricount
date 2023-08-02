class Expense < ApplicationRecord
  validates :title, presence: true
  validates :amount, presence: true

  belongs_to :participant
  has_one :activity, through: :participant
  has_one :user, through: :participant
end
