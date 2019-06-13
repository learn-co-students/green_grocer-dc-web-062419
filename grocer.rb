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
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost], :clearance => cart[name][:clearance]}
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart

end


def apply_clearance(cart)

	cart.each do |item, details|
		if  details[:clearance] == true
			details[:price] = (details[:price]*0.80).round(2)
		end
	end

end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated, coupons)
  total_cart = apply_clearance(couponed_cart)
  total = 0
  total_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  if total > 100
  total = total * 0.9 
  end
  total
  
end

