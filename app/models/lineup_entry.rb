class LineupEntry < ApplicationRecord
  belongs_to :lineup
  belongs_to :player
  # batting_orderは1~9の整数で、選手の打順をあらわし、重複する数字は許されない
  validates :player_id, uniqueness: { scope: :lineup_id, message: "同じ選手を複数回登録することはできません" }
  validates :batting_order, presence: true, uniqueness: { scope: :lineup_id, message: "同じ打順を複数回登録することはできません" },
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 9 }
end
