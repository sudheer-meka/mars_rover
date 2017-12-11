require "./processor"

RSpec.describe 'processor integrity' do
  let(:command_text) {
    <<-COMMANDS
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
    COMMANDS
  }

  subject { Processor.new(command_text).process }
  it { is_expected.to eq "1 3 N\n5 1 E\n" }
end