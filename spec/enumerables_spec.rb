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
  it 'can handle case when no parameter, false or nil is given' do
    array = [true, true, 'true', true, true]
    expect(array.my_all?).to be(true)
    expect(array.my_all?(nil)).to be(false)
    expect(array.my_all?(false)).to be(false)
    array.push(false)
    expect(array.my_all?).to be(false)
    expect(array.my_all?(nil)).to be(false)
    expect(array.my_all?(false)).to be(false)
    array.pop
    array.push(nil)
    expect(array.my_all?).to be(false)
    expect(array.my_all?(nil)).to be(false)
    expect(array.my_all?(false)).to be(false)
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
  it 'can handle case when no parameter, false or nil is given' do
    array = [true, true, 'true', true, true]
    expect(array.my_any?).to be(true)
    expect(array.my_any?(nil)).to be(false)
    expect(array.my_any?(false)).to be(false)
    array.push(false)
    expect(array.my_any?).to be(true)
    expect(array.my_any?(nil)).to be(false)
    expect(array.my_any?(false)).to be(true)
    array.pop
    array.push(nil)
    expect(array.my_any?).to be(true)
    expect(array.my_any?(nil)).to be(true)
    expect(array.my_any?(false)).to be(false)
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
  it 'can handle case when no parameter, false or nil is given' do
    array = [true, true, 'true', true, true]
    expect(array.my_none?).to be(false)
    expect(array.my_none?(nil)).to be(true)
    expect(array.my_none?(false)).to be(true)
    array.push(false)
    expect(array.my_none?).to be(false)
    expect(array.my_none?(nil)).to be(true)
    expect(array.my_none?(false)).to be(false)
    array.pop
    array.push(nil)
    expect(array.my_none?).to be(false)
    expect(array.my_none?(nil)).to be(false)
    expect(array.my_none?(false)).to be(true)
  end
end

RSpec.describe '#my_count' do
  it 'counts the elements equal to argument' do
    fruits = %w[mango banana apple apple orange]
    favorites = fruits.my_count('apple')
    expect(favorites).to eq(2)
  end
  it 'returns the number of items' do
    ary = [1, 2, 4, 2]
    result = ary.my_count
    expect(result).to eq(4)
  end
  it 'counts the elements which yield true' do
    ary = [1, 2, 4, 2, 3, 6, 9, 11, 22, 34, 15]
    result = ary.my_count { |number| number % 3 == 0 }
    expect(result).to eq(4)
  end
  it 'returns zero when empty' do
    expect([].my_count).to eq(0)
  end
end

RSpec.describe '#my_map' do
  it 'returns a transformed array of numbers' do
    array = [1, 2, 4, 2, 3, 6, 9, 11, 22, 34, 15]
    result = array.my_map { |n| n**4 }
    expected = array.map { |n| n**4 }
    expect(result).to eq(expected)
  end
  it 'returns a transformed array of strings' do
    array = %w[apple mango banana kiwi coconut]
    result = array.my_map { |w| "i like #{w}" }
    expected = array.map { |w| "i like #{w}" }
    expect(result).to eq(expected)
  end
  it 'returns Enumerator when no block is given' do
    array = %w[apple mango banana kiwi coconut]
    result = array.map # change this to my_map
    expect(result).to be_a Enumerator
  end
end

RSpec.describe '#my_inject' do
  it 'when block is given' do
    array = [1, 2, 4, 2, 3, 6, 9, 11, 22, 34, 15]
    result = array.inject { |product, n| product + n }
    expected = array.reduce { |product, n| product + n }
    expect(result).to eq(expected)
  end
  it 'when proc is given' do
    result = (5..10).inject(:+)
    expected = (5..10).reduce(:+)
    expect(result).to eq(expected)
  end
  it 'when initial value and a proc is given' do
    result = (5..10).inject(1, :*)
    expected = (5..10).reduce(1, :*)
    expect(result).to eq(expected)
  end
  it 'when initial value and a block is given' do
    result = (5..10).inject(1) { |product, n| product * n }
    expected = (5..10).reduce(1) { |product, n| product * n }
    expect(result).to eq(expected)
  end
  it 'find the longest word' do
    result = %w[cat sheep bear].inject do |memo, word|
      memo.length > word.length ? memo : word
    end
    expected = %w[cat sheep bear].reduce do |memo, word|
      memo.length > word.length ? memo : word
    end

    expect(result).to eq(expected)
  end
end
