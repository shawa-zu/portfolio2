FactoryBot.define do
  factory :player do
    association :user
    name { "テスト" }
    team { "テスト" }
    position { "テスト" }
    stat_1b { 0.2 }
    stat_2b { 0.1 }
    stat_3b { 0.05 }
    stat_hr { 0.1 }
  end
end
