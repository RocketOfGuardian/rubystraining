fib = [0, 1]
while (fib.last) + fib[fib.count - 2] < 100
	fib << (fib.last) + fib[fib.count - 2]
end
puts fib