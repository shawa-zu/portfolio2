class Lineup < ApplicationRecord
  belongs_to :user
  has_many :lineup_entries, dependent: :destroy
  has_many :players, through: :lineup_entries
  accepts_nested_attributes_for :lineup_entries

  validates :name, presence: true
  validates :description, length: { maximum: 500 }
end
