#!/usr/bin/env ruby

require_relative '../enumerables'

RSpec.describe '#my_each' do
  it 'loops into an array and finds the sum' do
    array = [1, 2, 3, 4, 5]
    sum = 0
    array.my_each do |number|
      sum += number
    end
    expect(sum).to eq(15)
  end
  it 'loops through an array and concatenates a String' do
    array = ['hello ', 'world ', 'how are you?']
    concat = ''
    array.my_each do |word|
      concat += word
    end
    expect(concat).to eq('hello world how are you?')
  end
  it 'returns Enumerator if no block given' do
    array = [10]
    enumerator = array.my_each
    expect(enumerator).to be_a Enumerator
  end
  it 'returns the array itself when block given' do
    array = [10, 20, 30, 40, 50, 60]
    returned = array.my_each {}
    expect(returned).to be(array)
  end
  it 'returns the range itself when block given' do
    range = (1..10)
    returned = range.my_each {}
    expect(returned).to be(range)
  end
end

RSpec.describe '#my_each_with_index' do
  it 'loops into an array and finds the sum of array and max index' do
    array = [5, 4, 3, 2, 1]
    sum = 0
    max_index = 0
    array.my_each_with_index do |element, index|
      sum += element
      max_index = index >= max_index ? index : max_index
    end
    expect(sum).to eq(15)
    expect(max_index).to eq(4)
  end
  it 'loops into an array and finds the concatenation of array and max index' do
    array = ['hello ', 'beautiful ', 'world']
    concatenation = ''
    max_index = 0
    array.my_each_with_index do |element, index|
      concatenation += element
      max_index = index >= max_index ? index : max_index
    end
    expect(concatenation).to eq('hello beautiful world')
    expect(max_index).to eq(2)
  end
  it 'returns Enumerator if no block given' do
    array = [10]
    enumerator = array.my_each_with_index
    expect(enumerator).to be_a Enumerator
  end
  it 'returns the array itself when block given' do
    array = [10, 20, 30, 40, 50, 60]
    returned = array.my_each_with_index {}
    expect(returned).to be(array)
  end
  it 'returns the range itself when block given' do
    range = (1..10)
    returned = range.my_each_with_index {}
    expect(returned).to be(range)
  end
end

RSpec.describe '#my_select' do
  it 'it filters the selected item in the array' do
    fruits = %w[mango banana apple orange]
    expected = 'mango'
    favorites = fruits.select { |fruit| fruit == expected }
    expect(favorites).to eq([expected])
  end
end
