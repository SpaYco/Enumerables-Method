# rubocop:disable Style/CaseEquality
module Enumerable
  def my_each
    return to_enum if block_given? == false

    length.times do |v|
      yield(self[v])
    end
  end

  def my_each_with_index
    return to_enum if block_given? == false

    length.times do |v|
      yield(self[v], v)
    end
  end

  def my_select
    return to_enum if block_given? == false

    arr = []
    length.times do |v|
      arr.push(self[v]) if yield(self[v])
    end
    arr
  end

  def my_checker(var, arg)
    !var.nil? && var != false && (arg === var || !(var =~ arg).nil?) ? true : false
  end

  def my_all?(arg = nil)
    result = 0
    my_each do |v|
      if block_given? && yield(v) == true
        result += 1
      elsif my_checker(v, arg) == true
        result += 1
      end
    end
    result == length
  end

  def my_any?(arg = nil)
    my_each do |v|
      return true if block_given? && yield(v) == true
      return true if my_checker(v, arg) == true
    end
    false
  end

  def my_none?(arg = nil)
    result = 0
    my_each do |v|
      if block_given? && yield(v) == true
        result += 1
      elsif my_checker(v, arg) == true
        result += 1
      end
    end
    result.zero? ? true : false
  end

  def my_count(*arg)
    result = 0
    if !arg[0].nil?
      length.times do |v|
        result += 1 if self[v] == arg[0]
      end
    elsif block_given?
      length.times do |v|
        result += 1 if yield(self[v])
      end
    else
      length.times do |_v|
        result += 1
      end
    end
    result
  end

  def my_map(&proc)
    result = []
    if !proc.nil?
      length.times do |v|
        yield_var = proc.call(self[v])
        result.push(yield_var)
      end
    else
      length.times do |v|
        yield_var = yield(self[v])
        result.push(yield_var)
      end
    end
    result
  end

  def my_inject(*arg)
    self_arr = to_a
    result = Numeric === arg[0] ? arg[0] : 0
    self_arr.length.times { |v| result = yield(result, self_arr[v]) } if block_given?
    self_arr.length.times { |v| result = result.public_send(arg[1], self_arr[v]) } unless arg[1].nil?
    self_arr.length.times { |v| result = result.public_send(arg[0], self_arr[v]) } if arg[1].nil?
    result
  end

  def multiply_els
    my_inject do |sum, n|
      sum * n
    end
  end
end
# rubocop:enable Style/CaseEquality
