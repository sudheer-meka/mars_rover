require './position/direction'

RSpec.describe Position::Direction do

  describe '#new' do
    context 'when direction is invalid' do
      subject { Position::Direction.new(:left) }
      it { is_expected_to_raise RuntimeError }
    end

    context 'when direction is valid' do
      subject { Position::Direction.new(:north) }
      it 'sets the side correctly' do
        expect(subject.side).to eq :north
      end
    end
  end

  context 'when rotated' do
    shared_examples_for "a direction side changer" do |rotation, initial_side, last_side|
      it "changes side from #{initial_side} to #{last_side}" do
        direction = Position::Direction.new(initial_side)
        direction.send rotation
        expect(direction.side).to eq last_side
      end
    end

    describe '#rotate_left' do
      examples = {
        :north => :west,
        :west => :south,
        :south => :east,
        :east => :north
      }
      examples.each do |initial_side, last_side|
        it_should_behave_like "a direction side changer", :rotate_left, initial_side, last_side
      end
    end

    describe '#rotate_right' do
      examples =  {
        :north => :east,
        :west => :north,
        :south => :west,
        :east => :south
      }
      examples.each do |initial_side, last_side|
        it_should_behave_like "a direction side changer", :rotate_right, initial_side, last_side
      end
    end

  end

  describe '#represented_side' do
    examples = {
      :north => 'N',
      :west => 'W',
      :south => 'S',
      :east => 'E'
    }
    examples.each do |side, represented|
      it "gives #{represented} for #{side}" do
        direction = Position::Direction.new(side)
        expect(direction.represented_side).to eq represented
      end
    end
  end
end