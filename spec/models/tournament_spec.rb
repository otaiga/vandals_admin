# encoding: utf-8
require 'spec_helper'

describe Tournament do 
  it 'has a valid factory' do
    expect(FactoryGirl.build(:tournament)).to be_valid
  end

  it 'is successful with all attributes' do
    tournament = FactoryGirl.build(:tournament)
    expect(tournament).to be_valid
  end

  it 'is invalid with no Tournament Name' do
    tournament = FactoryGirl.build(:tournament, name: nil)
    expect(tournament).to have(1).errors_on(:name)
  end

  it 'is invalid with no Tournament Location' do
    tournament = FactoryGirl.build(:tournament, tourn_location: nil)
    expect(tournament).to have(1).errors_on(:tourn_location)
  end

end