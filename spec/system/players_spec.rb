require 'rails_helper'

RSpec.describe "Players", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    login_as(user, scope: :user)
  end

  it "選手を登録し、一覧に表示される" do
    visit new_player_path

    fill_in "名前", with: "大谷翔平"
    fill_in "守備位置", with: "投手"
    fill_in "一塁打率", with: 0.2
    fill_in "二塁打率", with: 0.1
    fill_in "三塁打率", with: 0.05
    fill_in "本塁打率", with: 0.1
    click_button "登録"

    expect(page).to have_content "大谷翔平"
    expect(current_path).to eq players_path
  end
end
