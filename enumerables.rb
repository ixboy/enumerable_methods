#!/usr/bin/env ruby
module Enumerable
   def my_each
     for item in self
       yield(item)
     end
   end
 end
