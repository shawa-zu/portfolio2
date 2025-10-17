require 'rails_helper'

RSpec.describe "Lineups", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:players) { FactoryBot.create_list(:player, 9, user: user) }

  before do
    driven_by(:rack_test)
    login_as(user, scope: :user)
  end

  it "打順を作成し、シミュレーション結果を表示する" do
    visit new_lineup_path

    fill_in "※打順名", with: "テスト打線"

    # 9個のセレクトボックスを順に埋める
    select_boxes = all("select[name*='[player_id]']")
    select_boxes.each_with_index do |select_box, i|
      option_value = players[i].id.to_s
      select_box.find("option[value='#{option_value}']").select_option
    end

    click_button "登録" # 実際のボタン名に合わせる

    # 結果ページで「平均得点」が表示されていることを確認
    expect(page).to have_content "得点期待値"
  end
end
