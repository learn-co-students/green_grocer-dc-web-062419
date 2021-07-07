def consolidate_cart(cart)
  cart_count = Hash.new(0)
  cart.each do |v|
    cart_count[v] += 1
  end
  new_cart = Hash.new()
  cart_count.each do |item_hash, count|
    item_hash.each do |item, deets|
      deets[:count] = count
      new_cart[item] = deets
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = Hash.new()
  saved_val = 0
  coupons.each do |coupon|
    cart.each do |item, deets|
      if item == coupon[:item] && coupon[:num] <= deets[:count]
        saved_val = cart[item][:count]
        cart[item][:count] = saved_val - coupon[:num]
        new_count =
          if new_cart["#{coupon[:item]} W/COUPON"].nil?
            1
          else
            new_cart["#{coupon[:item]} W/COUPON"][:count] += 1
          end
        new_cart["#{coupon[:item]} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[coupon[:item]][:clearance],
          :count => new_count
          }
      else
        new_cart
      end
    end
  end
  new_cart.merge(cart)
end

def apply_clearance(cart)
  cart.each do |item, deets|
    if deets[:clearance]
      deets[:price] = (deets[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0.0
  cart.each do |item, deets|
    total = total + deets[:price]*deets[:count]
  end
  if total > 100
    total = total * 0.9
  end
  total
end
