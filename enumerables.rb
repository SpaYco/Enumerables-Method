module Enumerable
  def my_each
    length.times do |v|
      yield(self[v])
    end
  end

  def my_each_with_index
    length.times do |v|
      yield(self[v], v)
    end
  end

  def my_select
    arr = []
    length.times do |v|
      arr.push(self[v]) if yield(self[v])
    end
    arr
  end
end
include Enumerable
