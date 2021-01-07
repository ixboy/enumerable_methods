#!/usr/bin/env ruby
require_relative '../enumerables'
RSpec.describe '#my_each' do
  it 'loops into an array and finds the sum' do
    array = [1, 2, 3, 4, 5]
    sum = 0
    array.each do |number|
      sum += number
    end
    expect(sum).to eq(15)
  end

  it 'loops through an array and concatenates a String' do
    array = ['hello', 'world', 'how are you?']
    concat = ''
    array.each do |word|
      concat += word
    end
    expect(concat).to eq('helloworldhow are you?')
  end
end
