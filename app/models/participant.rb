class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_many :expenses, dependent: :destroy
end
