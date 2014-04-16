class AdminController < ApplicationController
before_action :authenticate_user!
def index
  @fixtures = Fixture.all
  @tournament_fixture = @fixtures.group_by(&:tournament)
end
end
