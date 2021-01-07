#!/usr/bin/env ruby

# rubocop:disable Style/For

module Enumerable
  def my_each
    return to_enum unless block_given?

    for item in self
      yield(item)
    end
  end
end

# rubocop:enable Style/For
