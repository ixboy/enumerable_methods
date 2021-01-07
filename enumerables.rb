#!/usr/bin/env ruby

# rubocop:disable Style/For

module Enumerable
  def my_each
    return to_enum unless block_given?

    for item in self
      yield(item)
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    new_array = []
    my_each do |item|
      new_array << item if yield(item)
    end
    new_array
  end

  def my_all?
    # return to_enum unless block_given?

    my_each do |item|
      return false unless yield(item)
    end
    true
  end
end

# rubocop:enable Style/For
