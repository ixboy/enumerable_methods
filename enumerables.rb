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

    length.times do |index|
      yield(self[index], index)
    end
    self
  end
end

# rubocop:enable Style/For
