def consolidate_cart(cart)
	i = 0
	s = {}
	cart.each do |item|
		item.map do |name, info|
		s[name] = info
		s[name][:count] = 0
		
		cur = name
	cart.each do |item|
		item.map do |name2, info2|
			if name2 == cur
				s[name][:count] += 1
			end
			
	end
	end
end
i += 1
end.uniq
s
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

