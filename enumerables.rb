# rubocop:disable Style/CaseEquality, Metrics/ModuleLength, Metrics/CyclomaticComplexity
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
    aclass = arg.class
    !var.nil? && (arg === var || (aclass == Regexp && !(var =~ arg).nil?) || (arg.nil? && var != false)) ? true : false
  end

  def my_all?(arg = nil)
    result = 0
    my_each do |v|
      if block_given?
        result += 1 if yield(v) == true
      elsif my_checker(v, arg) == true
        result += 1
      end
    end
    result == length
  end

  def my_any?(arg = nil)
    my_each do |v|
      if block_given?
        return true if yield(v) == true
      elsif my_checker(v, arg) == true
        return true
      end
    end
    false
  end

  def my_none?(arg = nil)
    result = 0
    my_each do |v|
      if block_given?
        result += 1 if yield(v) == true
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

  def my_map(*proc)
    return to_enum unless !proc[0].nil? || block_given?

    result = []
    if !proc[0].nil?
      length.times do |v|
        proc_var = proc[0].call(self[v])
        result.push(proc_var)
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
    result = arg[0] if Numeric === arg[0]
    operator = Numeric === arg[0] ? arg[1] : arg[0]
    if block_given?
      result = Numeric === self_arr[0] ? 0 : ''
      self_arr.length.times { |v| result = yield(result, self_arr[v]) }
    else
      self_arr.length.times { |v| result = result.public_send(operator, self_arr[v]) }
    end
    result
  end

  def multiply_els
    my_inject { |sum, n| sum * n }
  end
end
# rubocop:enable Style/CaseEquality, Metrics/ModuleLength, Metrics/CyclomaticComplexity
