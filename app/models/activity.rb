class Activity < ApplicationRecord
  validates :title , presence: true
  validates :currency, inclusion: { in: %w[USD EUR GBP] }
  validates :category, inclusion: { in: %w[Couple Travel Event Roomate Project Other] }

  has_many :participants
  has_many :users, through: :participants
  has_many :expenses, through: :participants
end
