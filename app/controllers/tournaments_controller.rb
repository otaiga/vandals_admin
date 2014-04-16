class TournamentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tourn_params)
    if @tournament.save
      redirect_to root_path, notice: 'Tournament Successfully Created'
    else
      render action: 'new'
    end
  end


  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(tourn_params)
      redirect_to root_path, notice: 'Successfully updated Tournament'
    else
      render action: 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    redirect_to root_path, notice: 'Successfully Destroyed Tournament'
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def index
    @tournaments = Tournament.all
  end

  private

  def tourn_params
    params.require(:tournament).permit(:id, :name, :tourn_date, :tourn_location)
  end
end
