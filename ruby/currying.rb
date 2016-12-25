recurse = lambda do |f, a, b, acc|
  return acc if a > b
  recurse.call(f, a + 1, b, acc += f.call(a))
end

# This solution is mory ruby, but less functional IMO
# recurse = lambda do |f, a, b|
#   s = 0
#   a.upto(b) { |n| s += f.call(n) }
#   s
# end

sum = lambda { |x| x }
product = lambda { |x| x * x }

p recurse.call(sum, 1, 3, 0)
p recurse.call(product, 1, 3, 0)

# Here is what we are doing here:
# (3 * 3) * (4 * 4) #=> 144
# so we are defining the square function (x * x)
# and the combine function for each int between a and b
# (a * b) where b is in fact a + 1 until a == b
# map_reduce will go over each int(n) apply square
# and multiply it with by square of n+1
map_reduce = lambda do |f, combine, zero, a, b|
  return zero if a > b
  combine.call(f.call(a), map_reduce.call(f, combine, zero, a + 1, b))
end

product = lambda do |f, a, b|
  map_reduce.call(f, lambda { |x, y| x * y }, 1, a, b)
end

square = lambda { |x| x * x }

currying = product.curry
product_curried = currying.call(square)
p product_curried.call(3, 4)
# or directly product.call(square, 3, 4)
