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

  def my_all?
    result = true
    length.times do |v|
      result = false if yield(self[v]) != true
      break unless result == true
    end
    result
  end

  def my_any?
    result = false
    length.times do |v|
      result = true if yield(self[v])
      break unless result == false
    end
    result
  end

  def my_none?
    result = true
    length.times do |v|
      result = false if yield(self[v])
      break unless result == true
    end
    result
  end

  def my_count
    result = 0
    length.times do |v|
      result += 1 if yield(self[v])
    end
    result
  end

  def my_map
    result = []
    length.times do |v|
      yiel_var = yield(self[v])
      result.push(yiel_var)
    end
    result
  end

  def my_inject
    self_arr = to_a
    result = self_arr[0]
    (self_arr.length - 1).times do |v|
      yiel_var = yield(result, self_arr[v + 1])
      result = yiel_var
    end
    result
  end
end
include Enumerable
