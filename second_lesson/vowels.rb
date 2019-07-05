hash = Hash.new(0)
index = 0
vowels = [:a, :e, :i, :o, :u, :y]

(:a..:z).each do |letter|
    hash[letter] = index if vowels.include?(letter)
    index += 1
end

print hash
