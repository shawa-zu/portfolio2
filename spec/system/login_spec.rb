require 'rails_helper'

RSpec.describe "Login", type: :system do
  let!(:user) { create(:user) }

  it "logs in and shows home" do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password123"
    click_button "ログイン"
    expect(page).to have_current_path(root_path)
  end
end