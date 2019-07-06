hash = {}
index = 0
vowels = %i[a e i o u y]

(:a..:z).each.with_index(1) do |letter, index| 
  hash[letter] = index if vowels.include?(letter)
end

print hash
