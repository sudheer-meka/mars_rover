require './controller'

RSpec.describe Controller do

  let(:rover) { mock('rover') }
  let(:controller) { Controller.new(rover: rover) }
  let(:turn_left_command) do
    mock('command').tap do |command|
      command.expects(:execute_on).with(rover).returns('Turned Left')
    end
  end
  let(:turn_right_command) do
    mock('command').tap do |command|
      command.stubs(:execute_on).with(rover).returns('Turned Right')
    end
  end

  describe '#new' do
    subject { controller.instance_variable_get :@rover }
    it { is_expected.to eq rover }
  end

  describe '#send_command' do
    context 'when command not found' do
      subject { controller.send_command 'unknown command' }
      it { is_expected_to_raise RuntimeError }
    end
    context 'when command found' do
      before { Command.expects('[]').with('L').returns(turn_left_command) }
      subject { controller.send_command 'L' }
      it { is_expected.to eq 'Turned Left' }
    end
  end

  describe '#send_commands' do
    before do
      Command.expects('[]').with('L').returns(turn_left_command)
      Command.stubs('[]').with('R').returns(turn_right_command)
    end
    subject { controller.send_commands 'LRR' }
    it { is_expected.to eq ['Turned Left','Turned Right','Turned Right'] }
  end

end