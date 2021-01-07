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
    array = ['hello ', 'world ', 'how are you?']
    concat = ''
    array.each do |word|
      concat += word
    end
    expect(concat).to eq('hello world how are you?')
  end
  it 'returns Enumerator if no block given' do
    array = [10]
    enumerator = array.each
    expect(enumerator).to be_a Enumerator
  end
  it 'returns the array itself when block given' do
    array = [10, 20, 30, 40, 50, 60]
    returned = array.each {}
    expect(returned).to be(array)
  end
  it 'returns an array with all the elements in range' do
    range = (1..10)
    returned = range.each {}
    expect(returned).to be(range)
  end
end
