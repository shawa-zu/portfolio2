class HomeController < ApplicationController
  def index
    if user_signed_in?
      @lineups = current_user.lineups.order(created_at: :desc).limit(3)
      @players = current_user.players.order(created_at: :desc).limit(4)
    else
      @lineups = []
      @players = []
    end
  end
end
