module IsExpectedBlock
  def is_expected_to_raise(*args)
    expect { subject }.to raise_error *args
  end
end