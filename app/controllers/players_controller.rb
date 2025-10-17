class PlayersController < ApplicationController
  before_action :set_player, only: [ :edit, :update, :destroy ]
  def index
    @q = current_user.players.ransack(params[:q])
    @players = @q.result(distinct: true)
                .order(created_at: :desc)
                .page(params[:page])
                .per(20)
  end

  def new
    @player = Player.new
  end

  def create
    @player = current_user.players.build(player_params)
    if @player.save
      flash[:notice] = "選手を作成しました"
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
      flash[:notice] = "選手を更新しました"
      redirect_to players_path
    else
      flash.now[:alert] = @player.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    flash[:notice] = "選手を削除しました"
    redirect_to players_path
  end

  def autocomplete
    field = params[:field]
    query = params[:query]

    if %w[name team position].include?(field)
      results = current_user.players
                            .where("#{field} ILIKE ?", "%#{query}%")
                            .distinct
                            .limit(10)
                            .pluck(field)
      render json: results
    else
      render json: []
    end
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
