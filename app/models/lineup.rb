class Lineup < ApplicationRecord
  belongs_to :user
  has_many :lineup_entries, dependent: :destroy
  has_many :players, through: :lineup_entries
  accepts_nested_attributes_for :lineup_entries

  validates :name, presence: true
  validates :description, length: { maximum: 500 }

  after_save :calculate_expected_score

  private

  def calculate_expected_score
    batting_order = lineup_entries.includes(:player).order(:batting_order).map(&:player)
    score = average_game_score(batting_order, trials: 1000)
    update_column(:expected_score, score)
  end

  def average_game_score(batting_order, trials: 1000)
    total = 0
    trials.times do
      total += simulate_game(batting_order)
    end
    (total.to_f / trials).round(2)
  end

  # 9イニングの試合シミュレーション
  def simulate_game(batting_order)
    total_score = 0
    batter_index = 0

    9.times do
      inning_result = simulate_inning(batting_order, batter_index)
      total_score += inning_result[:score]
      batter_index = inning_result[:next_index]
    end

    total_score
  end

  # 1イニングの処理（前に作ったやつ）
  def simulate_inning(batting_order, start_index)
    bases = [ nil, nil, nil ]
    outs = 0
    score = 0
    batter_index = start_index

    while outs < 3
      batter = batting_order[batter_index]
      result = sample_result(batter)

      case result
      when :single
        bases, score = handle_single(bases, score, batter)
      when :double
        bases, score = handle_double(bases, score, batter)
      when :triple
        bases, score = handle_triple(bases, score, batter)
      when :home_run
        bases, score = handle_home_run(bases, score, batter)
      when :out
        outs += 1
      end

      batter_index = (batter_index + 1) % batting_order.size
    end

    { score: score, next_index: batter_index }
  end

  def sample_result(player)
    stats = {
      single: player.stat_1b,
      double: player.stat_2b,
      triple: player.stat_3b,
      home_run: player.stat_hr,
      out: player.stat_out
    }
    rand_val = rand
    cumulative = 0.0
    stats.each do |result, prob|
      cumulative += prob
      return result if rand_val < cumulative
    end
    :out
  end

  def handle_single(bases, score, batter)
    score += 1 if bases[2] # 三塁ランナーはホームイン
    bases[2] = bases[1]    # 二塁→三塁
    bases[1] = bases[0]    # 一塁→二塁
    bases[0] = batter      # 打者が一塁へ
    [ bases, score ]
  end

  def handle_double(bases, score, batter)
    score += 1 if bases[2]
    score += 1 if bases[1]
    bases[2] = bases[0]    # 一塁→三塁
    bases[1] = batter      # 打者が二塁へ
    bases[0] = nil
    [ bases, score ]
  end

  def handle_triple(bases, score, batter)
    bases.compact.each { |_| score += 1 }
    bases = [ nil, nil, batter ]
    [ bases, score ]
  end

  def handle_home_run(bases, score, batter)
    bases.compact.each { |_| score += 1 }
    score += 1 # 打者自身
    bases = [ nil, nil, nil ]
    [ bases, score ]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[
      name description expected_score created_at updated_at user_id
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[lineup_entries players user]
  end
end
