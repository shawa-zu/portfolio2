class PlayersController < ApplicationController
  before_action :set_player, only: [ :edit, :update, :destroy ]
  def index
    @players = current_user.players.order(created_at: :desc)
  end

  def new
    @player = Player.new
  end

  def create
    @player = current_user.players.build(player_params)
    if @player.save
      flash[:notice] = "Player created successfully."
      redirect_to players_path
    else
      flash.now[:alert] = @player.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @player.update(player_params)
      flash[:notice] = "Player updated successfully."
      redirect_to players_path
    else
      flash.now[:alert] = @player.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    flash[:notice] = "Player deleted successfully."
    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:name, :team, :position, :description,
                                   :stat_1b, :stat_2b, :stat_3b, :stat_hr)
  end

  def set_player
    @player = current_user.players.find(params[:id])
  end
end
