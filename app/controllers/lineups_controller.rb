class LineupsController < ApplicationController
  before_action :set_lineup, only: [ :show, :edit, :update, :destroy ]
  def index
    @lineups = current_user.lineups.order(created_at: :desc)
  end

  def show
  end

  def new
    @lineup = current_user.lineups.build
    @players = current_user.players.order(:name)
    (1..9).each do |i|
      @lineup.lineup_entries.build(batting_order: i)
    end
  end

  def create
    @lineup = current_user.lineups.build(lineup_params)
    if @lineup.save
      flash[:notice] = "打順を作成しました。"
      redirect_to lineups_path
    else
      flash.now[:alert] = @lineup.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

def edit
  @lineup = current_user.lineups.find(params[:id])
  @players = current_user.players.order(:name)
end

def update
  @lineup = current_user.lineups.find(params[:id])
  if @lineup.update(lineup_params)
    flash[:notice] = "打線を更新しました。"
    redirect_to lineups_path
  else
    flash.now[:alert] = @lineup.errors.full_messages.to_sentence
    render :edit, status: :unprocessable_entity
  end
end

  def destroy
    @lineup.destroy
    redirect_to lineups_url, notice: "打線を削除しました。"
  end

  private
  def set_lineup
    @lineup = current_user.lineups.find(params[:id])
  end

  def lineup_params
    params.require(:lineup).permit(:name, :description, :expected_score,
                                   lineup_entries_attributes: [ :id, :player_id, :batting_order, :_destroy ])
  end
end
