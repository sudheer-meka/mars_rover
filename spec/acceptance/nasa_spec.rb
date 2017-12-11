require "./martian_rover"
require "./controller"
require "./command"
require "./plateau"

RSpec.describe 'NASA specs' do

  let(:plateau) { Plateau.new 5,5 }
  let(:command) { Command }

  before do
    command.register 'L', :turn_left
    command.register 'R', :turn_right
    command.register 'M', :move
  end

  describe 'rover1' do
    let(:initial_location) { Position::Location.new(1, 2, plateau) }
    let(:initial_direction) { Position::Direction.new :north }
    let(:rover) { MartianRover.new(initial_location, initial_direction) }
    let(:controller) { Controller.new rover: rover }
    before { controller.send_commands 'LMLMLMLMM' }

    it 'reports last position' do
      expect(rover.report).to eq '1 3 N'
    end
  end

  describe 'rover2' do
    let(:initial_location) { Position::Location.new(3, 3, plateau) }
    let(:initial_direction) { Position::Direction.new :east }
    let(:rover) { MartianRover.new(initial_location, initial_direction) }
    let(:controller) { Controller.new rover: rover }
    before { controller.send_commands 'MMRMMRMRRM' }

    it 'reports last position' do
      expect(rover.report).to eq '5 1 E'
    end
  end

end