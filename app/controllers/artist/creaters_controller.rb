class Artist::CreatersController < ApplicationController

  def new
    @creater = Creater.new
  end

  def create
    @creater = Creater.new(creater_params)
    @listener = Listener.find_by(id: @creater.listener_id)
    @listener.listener_type = 1
    @listener.save
    @creater.save
    redirect_to artist_creaters_path
  end

  def show
    @creater = Creater.find(params[:id])
    # @albums = @creater.albums.page(params[:page])
  end

  def index
    @creaters = Creater.all
  end

  private

  def creater_params
    params.require(:creater).permit(:listener_id)
  end

end
