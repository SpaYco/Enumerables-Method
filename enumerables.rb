module Enumerable
  def my_each
    return Enumerator if block_given? == false

    length.times do |v|
      yield(self[v])
    end
  end

  def my_each_with_index
    return Enumerator if block_given? == false

    length.times do |v|
      yield(self[v], v)
    end
  end

  def my_select
    return Enumerator if block_given? == false

    arr = []
    length.times do |v|
      arr.push(self[v]) if yield(self[v])
    end
    arr
  end

  def my_all?(arg = nil)
    result = true
    length.times do |v|
      var = self[v]
      result = false if (!arg.nil? && var != arg && var.class != arg && !(var =~ arg).nil?) || var == false
    end
    result
  end

  def my_any?(*arg)
    result = false
    length.times do |v|
      var = self[v]
      result = true if var == arg[0] || var.class == arg[0] || !(var =~ arg[0]).nil? || var == true
      break if result == true
    end
    result
  end

  def my_none?(*arg)
    checker = any?(arg[0])
    checker != true
  end

  def my_count(*arg)
    result = 0
    if !arg[0].nil?
      length.times do |v|
        result += 1 if self[v] == arg[0]
      end
    else
      length.times do |_v|
        result += 1
      end
    end
    result
  end

  def my_map
    return Enumerator if block_given? == false

    result = []
    length.times do |v|
      yiel_var = yield(self[v])
      result.push(yiel_var)
    end
    result
  end

  def my_inject(*arg)
    self_arr = to_a
    result = self_arr[0]
    if arg[0].nil?
      (self_arr.length - 1).times do |v|
        yiel_var = yield(result, self_arr[v + 1])
        result = yiel_var
      end
    else
      self_arr.length.times do |v|
        next if v.zero?

        yiel_var = result.public_send(arg[0], self_arr[v])
        result = yiel_var
      end
    end
    result
  end

  def multiply_els
    return Enumerator if block_given? == false

    my_inject do |sum, n|
      sum * n
    end
  end
end
