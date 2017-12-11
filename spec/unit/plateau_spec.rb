require './plateau'

RSpec.describe Plateau do

  describe '#new' do
    subject { Plateau.new 3,5 }
    it 'sets width and height' do
      expect(subject.instance_variable_get :@width).to eq 3
      expect(subject.instance_variable_get :@height).to eq 5
    end
  end

end