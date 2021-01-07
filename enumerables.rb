#!/usr/bin/env ruby

module Enumerable
  def my_each
    return to_enum unless block_given?

    # rubocop:disable Style/For
    for item in self
      yield(item)
    end
    # rubocop:enable Style/For
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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_all?(pattern = nil)
    if pattern.nil?
      my_each do |item|
        if block_given?
          return false unless yield(item)
        else
          return false unless item
        end
      end
    elsif pattern.is_a?(Class)
      my_each do |item|
        return false unless item.is_a?(pattern)
      end
    elsif pattern.is_a?(Regexp)
      my_each do |item|
        return false unless pattern.match?(item)
      end
    end
    true
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
