class FixturesController < ApplicationController
	before_action :authenticate_user!

  def index
    @fixtures = Fixture.all
    @tournament_fixture = @fixtures.group_by(&:tournament)
  end

  def new
    @fixture = Fixture.new
  end

  def create
    @fixture = Fixture.new(fixture_params)
    if @fixture.save
      redirect_to root_path, notice: 'Fixuture Successfully Created'
    else
      render action: 'new'
    end
  end


  def edit
    @fixture = Fixture.find(params[:id])
  end

  def update
    @fixture = Fixture.find(params[:id])
    if @fixture.update_attributes(fixture_params)
      redirect_to root_path, notice: 'Successfully updated Fixture'
    else
      render action: 'edit'
    end
  end

  def destroy
    @fixture = Fixture.find(params[:id])
    @fixture.destroy
    redirect_to root_path, notice: 'Successfully Destroyed Fixture'
  end

  def show
    @fixture = Fixture.find(params[:id])
  end


  private

  def fixture_params
    params.require(:fixture).permit(:id, :home_team, :away_team, :kickoff_time, :home_score_result, :away_score_result, :tournament_id)
  end
end
