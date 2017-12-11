require './position/location'

RSpec.describe Position::Location do

  let(:plateau) do
    mock('plateau') do
      stubs(:width).returns(5)
      stubs(:height).returns(5)
    end
  end

  context 'when changing coordinates' do
    shared_examples_for 'a coordinate changer' do |x_coordinate, y_coordinate|
      if [x_coordinate, y_coordinate].all? { |coord| coord.kind_of? Integer }
        if x_coordinate.between? 0, 5 and y_coordinate.between? 0, 5
          it 'sets the coordinates correctly' do
            expect(subject.instance_variable_get :@x_coordinate).to eq x_coordinate
            expect(subject.instance_variable_get :@y_coordinate).to eq y_coordinate
          end
        else
          context 'when coordinates pass boundaries' do
            it { is_expected_to_raise RuntimeError }
          end
        end
      else
        context 'when coordinates not numeric' do
          it { is_expected_to_raise RuntimeError }
        end
      end
    end

    DATA_SET = [['3', 5], [3, '5'], [3, 5], [-1,0], [2,-1], [7, 2], [3, 8]]

    describe '#new' do
      DATA_SET.each do |coordinates|
        it_behaves_like("a coordinate changer", coordinates[0], coordinates[1]) do
          subject { Position::Location.new(coordinates[0], coordinates[1], plateau) }
        end
      end
    end

    describe '#change_coordinates_to' do
      DATA_SET.each do |coordinates|
        it_behaves_like("a coordinate changer", coordinates[0], coordinates[1]) do
          subject do
            Position::Location.new(0, 0, plateau).tap do |location|
              location.change_coordinates_to(coordinates[0], coordinates[1])
            end
          end
        end
      end
    end
  end
  
  describe '#north_coordinates' do
    subject { Position::Location.new(3, 5, plateau).north_coordinates }
    it { is_expected.to eq([3, 6]) }
  end

  describe '#west_coordinates' do
    subject { Position::Location.new(3, 5, plateau).west_coordinates }
    it { is_expected.to eq([2, 5]) }
  end

  describe '#east_coordinates' do
    subject { Position::Location.new(3, 5, plateau).east_coordinates }
    it { is_expected.to eq([4, 5]) }
  end

  describe '#south_coordinates' do
    subject { Position::Location.new(3, 5, plateau).south_coordinates }
    it { is_expected.to eq([3, 4]) }
  end

  describe '#coordinates_of' do
    context 'when coordinate valid' do
      subject { Position::Location.new(3, 5, plateau).coordinates_of :north }
      it { is_expected.to eq [3, 6] }
    end
    context 'when coordinate not valid' do
      subject { Position::Location.new(3, 5, plateau).coordinates_of :invalid }
      it { is_expected_to_raise RuntimeError }
    end
  end
end