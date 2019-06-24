require 'pry'

def consolidate_cart(cart)
  tally = {}
  cart.each do |line_item|
    line_item.each do |item, attribute|
      tally[item] = {} 
      tally[item][:count] = 0
      attribute.each do |detail, spec| tally[item][detail] = spec
      end
    end
  end
  cart.each do |line_item|
    line_item.each do |item, attribute|
      tally[item][:count] += 1
    end
  end  
    tally
end


###############################################



def apply_coupons(cart, coupons)
  sum_cart = {}
  discounted_items = []
  coupons.each do |coupon|
    discounted_items << coupon[:item]
  end

  cart.each do |item, attribute|
    if discounted_items.include?(item) == true
    
      coupons.each do |coupon|
        sum_cart[item] = {}
          if coupon[:item] == item
            coupons.each do |coupon|
              sum_cart["#{coupon[:item]} W/COUPON"] = {}   
            end
            coupons.each do |coupon|
 #             binding.pry
#              if sum_cart["#{coupon[:item]} W/COUPON"] != {}   ##I'm not sure how to handle multiple coupons that are different. I can count coupons that are similar but not sure how to take different kinds of discounts  on the same types of items.
#                sum_cart["#{coupon[:item]} W/COUPON"] = {} 
#              end
              if sum_cart["#{coupon[:item]} W/COUPON"][:count] == nil
                sum_cart["#{coupon[:item]} W/COUPON"][:count] = coupon[:num]
              else
                sum_cart["#{coupon[:item]} W/COUPON"][:count] = sum_cart["#{coupon[:item]} W/COUPON"][:count] + coupon[:num]
              end
              sum_cart["#{coupon[:item]} W/COUPON"][:price] = (coupon[:cost] / coupon[:num])
              if sum_cart[item][:count] == nil
                sum_cart[item][:count] = cart[item][:count] - coupon[:num]
              else
                sum_cart[item][:count] = sum_cart[item][:count] - coupon[:num]
              end
            end
#            sum_cart[item][:count] = cart[item][:count] - coupon[:num]
            sum_cart[item][:price] = cart[item][:price]
            sum_cart[item][:clearance] = cart[item][:clearance]
            coupons.each do |coupon|
              sum_cart["#{coupon[:item]} W/COUPON"][:clearance] = cart[item][:clearance]
            end
          end  #this is the end of the if courpon item line 40
      end #this is the end of coupons.each do coupon line 36
    else
      sum_cart[item] = {}
      sum_cart[item] = attribute
#      binding.pry
    end
  end #this seems to be end of if discounted_items
#  binding.pry
  sum_cart
end





def apply_clearance(cart)
  adjusted_prices = {}
  cart.each do |item, attributes|
     adjusted_prices[item] = {}
     adjusted_prices[item] = attributes
#     binding.pry
    if adjusted_prices[item][:clearance] == true  
      adjusted_prices[item][:price] = (cart[item][:price]*(0.8)).round(2)
    end
  end
  adjusted_prices
end

def checkout(cart, coupons)
  consolidate_cart(cart)
end


cart =[
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]


coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]
#checkout(cart, coupons)