module Enumerable
    def my_each(arr)
        (arr.length).times do |v|
            yield(arr[v])
        end
    end
end
include Enumerable
my_each(["hi", "bye", "lol"]) do |k|
    puts k
end
