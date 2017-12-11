require_relative 'processor'

print Processor.new(File.read('input.txt')).process