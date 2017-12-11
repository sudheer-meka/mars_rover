require './position/position'

RSpec.describe Position do

  describe 'SIDES' do
    subject { Position::SIDES }
    it { is_expected.to eq [:north, :east, :south, :west] }
  end

  describe 'SIDE_REPRESENTATION' do
    subject { Position::SIDE_REPRESENTATION }
    it { is_expected.to eq %w(N E S W) }
  end

end