#!/usr/bin/env ruby

# rubocop:disable Metrics/ModuleLength
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
  def my_all?(pattern = (pattern_not_defined = true))
    my_each do |item|
      if block_given?
        return false unless yield(item)
      elsif pattern_not_defined
        return false unless item
      elsif pattern.is_a?(Class)
        return false unless item.is_a?(pattern)
      elsif pattern.is_a?(Regexp)
        return false unless pattern.match?(item)
      else
        return false unless pattern == item
      end
    end
    true
  end

  def my_any?(pattern = (pattern_not_defined = true))
    my_each do |item|
      if block_given?
        return true if yield(item)
      elsif pattern_not_defined
        return true if item
      elsif pattern.is_a?(Class)
        return true if item.is_a?(pattern)
      elsif pattern.is_a?(Regexp)
        return true if pattern.match?(item)
      elsif pattern == item
        return true
      end
    end
    false
  end

  def my_none?(pattern = (pattern_not_defined = true))
    my_each do |item|
      if block_given?
        return false if yield(item)
      elsif pattern_not_defined
        return false if item
      elsif pattern.is_a?(Class)
        return false if item.is_a?(pattern)
      elsif pattern.is_a?(Regexp)
        return false if pattern.match?(item)
      elsif pattern == item
        return false
      end
    end
    true
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def my_count(pattern = (pattern_not_defined = true))
    count = 0
    my_each do |item|
      count += if block_given?
                 yield(item) ? 1 : 0
               elsif pattern_not_defined
                 1
               else
                 item == pattern ? 1 : 0
               end
    end
    count
  end

  def my_map(proc = (proc_not_defined = true))
    new_array = []
    if proc_not_defined
      return to_enum unless block_given?

      my_each do |item|
        new_array << yield(item)
      end
    elsif proc.is_a?(Proc)
      my_each do |item|
        new_array << proc.call(item)
      end
    end
    new_array
  end

  def my_inject(*parameters)
    # Parameter discrimination logic
    if parameters.length == 1
      parameters[0].is_a?(Symbol) ? (symbol = parameters[0]) : (accumulator = parameters[0])
    elsif parameters.length > 1
      accumulator = parameters[0]
      symbol = parameters[1]
    end
    temporary = accumulator.nil? ? drop(1) : drop(0)
    accumulator = accumulator.nil? ? first(1)[0] : accumulator
    # Implementation of the algorithm
    temporary.my_each do |item|
      accumulator = block_given? ? yield(accumulator, item) : symbol.to_proc.call(accumulator, item)
    end
    accumulator
  end
end
# rubocop:enable Metrics/ModuleLength

def multiply_els(parameter)
  parameter.my_inject { |accumulator, number| accumulator * number }
end
