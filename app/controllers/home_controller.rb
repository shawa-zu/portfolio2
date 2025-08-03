class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @lineups = current_user.lineups.order(created_at: :desc).limit(3)
    @players = current_user.players.order(created_at: :desc).limit(4)
  end
end
