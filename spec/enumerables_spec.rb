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
    favorites = fruits.my_select { |fruit| fruit == expected }
    expect(favorites).to eq([expected])
  end
  it 'returns Enumerator if no block given' do
    array = []
    enumerator = array.my_select
    expect(enumerator).to be_a Enumerator
  end
end

RSpec.describe '#my_all?' do
  it 'returns true with no block and no falsy elements' do
    expect([true, true, nil, true, true].my_all?).to be(false)
    expect([true, true, true, true, false, true].my_all?).to be(false)
    expect([true, true, 1, 2, 3, 4, 'hello'].my_all?).to be(true)
  end
  it 'returns true with class argument and all elements are members' do
    expect([1, 2, 3, 4, 5, 6].my_all?(Integer)).to be(true)
    expect([1, 2.0, 3, 4, 5, 6].my_all?(Integer)).to be(false)
    expect(%w[a b c d e f g].my_all?(String)).to be(true)
    expect(['a', 'b', 1, 'c', 'd'].my_all?(String)).to be(false)
  end
  it 'returns true when all elements match the regex' do
    array = %w[one two three four five six seven]
    expect(array.my_all?(/t/)).to be(false)
    expect(array.my_all?(/[aeiou]/)).to be(true)
  end
  it 'returns true when given a block all elements evaluate to true' do
    array = %w[ant bear cat]
    expect(array.my_all? { |word| word.length >= 3 }).to be(true)
    expect(array.my_all? { |word| word.length >= 4 }).to be(false)
  end
  it 'returns true when no argument or block given in an empty array' do
    expect([].my_all?).to be(true)
  end
  it 'returns true when no block and nil or false argument' do
    expect([1, 2, 3, 4].my_all?).to be(true)
  end
end

RSpec.describe '#my_any?' do
  it 'returns true with no block and at least one truthy elements' do
    expect([true, true, nil, true, true].my_any?).to be(true)
    expect([false, nil, false, false].my_any?).to be(false)
    expect([true, true, 1, 2, 3, 4, 'hello'].my_any?).to be(true)
  end
  it 'returns true with class argument and any elements are members' do
    expect([1, 2, 3.7, 4.8, 5, 6].my_any?(Integer)).to be(true)
    expect([2.0, 3.1, 5.0, 6.0].my_any?(Integer)).to be(false)
    expect(%w[a b c d e f g].my_any?(String)).to be(true)
    expect([1, true, ['hey', 2.4], 2.0].my_any?(String)).to be(false)
  end
  it 'returns true when any elements match the regex' do
    array = %w[one two three four five six seven]
    expect(array.my_any?(/t/)).to be(true)
    expect(array.my_any?(/p/)).to be(false)
  end
  it 'returns true when given a block any elements evaluate to true' do
    array = %w[ant bear cat]
    expect(array.my_any? { |word| word.length >= 4 }).to be(true)
    expect(array.my_any? { |word| word.length >= 5 }).to be(false)
  end
  it 'returns false when no argument or block given in an empty array' do
    expect([].my_any?).to be(false)
  end
  it 'returns true when no block and nil or false argument' do
    expect([1, 2, 3, 4].my_any?).to be(true)
  end
end

RSpec.describe '#my_none?' do
  it 'returns true with no block and no truthy elements' do
    expect([true, true, nil, true, true].my_none?).to be(false)
    expect([false, nil, false, false].my_none?).to be(true)
    expect([true, true, 1, 2, 3, 4, 'hello'].my_none?).to be(false)
  end
  it 'returns true with class argument and no elements are members' do
    expect([1, 2, 3.7, 4.8, 5, 6].my_none?(Integer)).to be(false)
    expect([2.0, 3.1, 5.0, 6.0].my_none?(Integer)).to be(true)
    expect(%w[a b c d e f g].my_none?(String)).to be(false)
    expect([1, true, ['hey', 2.4], 2.0].my_none?(String)).to be(true)
  end
  it 'returns true when no elements match the regex' do
    array = %w[one two three four five six seven]
    expect(array.my_none?(/t/)).to be(false)
    expect(array.my_none?(/p/)).to be(true)
  end
  it 'returns true when given a block and no elements evaluate to true' do
    array = %w[ant bear cat]
    expect(array.my_none? { |word| word.length >= 4 }).to be(false)
    expect(array.my_none? { |word| word.length >= 5 }).to be(true)
  end
  it 'returns true when no argument or block given in an empty array' do
    expect([].my_none?).to be(true)
  end
  it 'returns false when no block and nil or false argument' do
    expect([1, 2, 3, 4].my_none?).to be(false)
  end
end
