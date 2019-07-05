products = {}

loop do

  puts 'product name: '
  product_name = gets.chomp

  if product_name == 'stop'
    break
  end

  puts 'price per one product: '
  price = gets.chomp.to_f

  puts 'quantity: '
  quantity = gets.chomp.to_f

  products[product_name] = {price: price, quantity: quantity}

end

puts products


total_cost = 0.0

products.each do |product_name, product_info|
  sum = product_info[:price] * product_info[:quantity]
  total_cost += sum
  puts "#{product_name} - #{sum} total cost"
end

puts "cost for overall products: #{total_cost}"
