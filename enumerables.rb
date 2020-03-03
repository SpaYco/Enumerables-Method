module Enumerable
    def my_each(arr)
        (arr.length).times do |v|
            yield(arr[v])
        end
    end
    def my_each_with_index(arr)
        (arr.length).times do |v|
            yield(arr[v], v)
        end
    end
end
include Enumerable
my_each(["hi", "bye", "lol"]) do |k|
    puts k
end

my_each_with_index(["hi", "bye", "lol"]) do |x, y|
    puts x
    puts y
end
