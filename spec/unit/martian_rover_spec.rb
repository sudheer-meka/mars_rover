require './martian_rover'

RSpec.describe MartianRover do
  let(:direction) { mock('direction') }
  let(:location) { mock('location') }
  let(:martian_rover) { MartianRover.new location, direction }

  describe '#new' do
    it 'sets direction and location' do
      expect(martian_rover.instance_variable_get :@direction).to eq direction
      expect(martian_rover.instance_variable_get :@location).to eq location
    end
  end

  describe '#turn_left' do
    subject { martian_rover.turn_left }
    it 'changes direction to left' do
      direction.expects(:rotate_left).returns('direction changed to left')
      is_expected.to eq 'direction changed to left'
    end
  end

  describe '#turn_right' do
    subject { martian_rover.turn_right }
    it do
      direction.expects(:rotate_right).returns('direction changed to right')
      is_expected.to eq 'direction changed to right'
    end
  end

  describe '#move' do
    subject { martian_rover.move }
    it do
      direction.expects(:side).returns :north
      location.expects(:coordinates_of).with(:north).returns([12, 26])
      location.expects(:change_coordinates_to).returns('coordinates settled')
      is_expected.to eq 'coordinates settled'
    end
  end

end