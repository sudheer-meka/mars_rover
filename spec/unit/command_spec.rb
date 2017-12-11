require './command'

RSpec.describe Command do

  describe '.instances' do
    context 'when empty' do
      before { Command.instance_variable_set :@instances, nil }
      subject { Command.instances }
      it { is_expected.to eq({}) }
    end

    context 'when not empty' do
      let(:command_instance) { Command.new(:test) }
      before { Command.instance_variable_set(:@instances, {test: command_instance}) }
      subject { Command.instances }
      it { is_expected.to eq({test: command_instance}) }
    end
  end

  describe '.register' do
    context 'when function not a symbol' do
      subject { Command.register('test', 'invalid function') }
      it { is_expected_to_raise RuntimeError }
    end

    context 'when function is a symbol' do
      before {  Command.register('test', :test_me) }
      subject do
        instances = Command.instance_variable_get :@instances
        instances['test'].instance_variable_get :@function
      end
      it { is_expected.to eq :test_me }
    end
  end

  describe '.[]' do
    context 'when command not registered' do
      subject { Command['unknown command'] }
      it { is_expected_to_raise RuntimeError }
    end
    context 'when command registered' do
      let(:command_instance) { Command.new(:test_me) }
      before {  Command.instance_variable_set(:@instances, { 'test' => command_instance }) }
      subject { Command['test'].instance_variable_get :@function }
      it { is_expected.to eq :test_me }
    end
  end

  describe '#new' do
    let(:command) { Command.new 'test' }
    subject { command.instance_variable_get :@function }
    it { is_expected.to eq 'test' }
  end

  describe '#execute_on' do
    let(:turn_left_command) { Command.new(:turn_left) }
    let(:delegator) do
      mock('rover').tap do |rover|
        rover.expects(:turn_left).returns('I turned left')
      end
    end
    it 'delegates the method to delegator' do
      result = turn_left_command.execute_on delegator
      expect(result).to eq 'I turned left'
    end
  end

end