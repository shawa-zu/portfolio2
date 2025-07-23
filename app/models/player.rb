class Player < ApplicationRecord
  belongs_to :user

  attribute :stat_1b, :float, default: 0.0
  attribute :stat_2b, :float, default: 0.0
  attribute :stat_3b, :float, default: 0.0
  attribute :stat_hr, :float, default: 0.0
  attribute :stat_out, :float, default: 1.0

  before_save :calculate_stat_out

  validates :name, presence: true
  validates :stat_1b, :stat_2b, :stat_3b, :stat_hr, :stat_out,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1.0 }
  validate :total_stats_cannot_exceed_one

  private
  # 後でerrorsオブジェクトについて調べとく
  def total_stats_cannot_exceed_one
    total = stat_1b.to_f + stat_2b.to_f + stat_3b.to_f + stat_hr.to_f + stat_out.to_f
    errors.add(:base, "合計値が1.0を超えています") if total > 1.0 
  end

  def calculate_stat_out
    self.stat_out = 1.0 - (stat_1b.to_f + stat_2b.to_f + stat_3b.to_f + stat_hr.to_f)
  end
end
