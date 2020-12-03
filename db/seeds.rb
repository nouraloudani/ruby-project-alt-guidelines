### USER ###

bill = User.create(username: "Billy", password: "abc123")
mark = User.create(username: "Marky", password: "abc1234")
kate = User.create(username: "Katie10", password: "abc12345")
jon = User.create(username: "Jonny", password: "abc123456")
sarah = User.create(username: "Sarah20", password: "abc1234567")



### VENDOR ###

ble = Vendor.create(name: "BL Electronics")
li = Vendor.create(name: "Luxe Interiors")
fresh = Vendor.create(name: "Fresh")


### ORDER ###

order1 = Order.create(user_id: bill.id, date: "June 1", completed: true)
order2 = Order.create(user_id: kate.id, date: "May 1", completed: true)
order3 = Order.create(user_id: sarah.id, date: "Jan 1", completed: false)
order4 = Order.create(user_id: bill.id, date: "July 3", completed: false)
order5 = Order.create(user_id: mark.id, date: "March 3", completed: true)



### PRODUCT ###

monitor = Product.create(name: "Monitor 22", vendor_id: ble.id, price: rand(100))
sofa = Product.create(name: "Sofa", vendor_id: li.id, price: rand(2000))
desk = Product.create(name: "Desk", vendor_id: li.id, price: rand(2000))
milk = Product.create(name: "Milk 1L", vendor_id: fresh.id, price: rand(5))


### ORDER_PRODUCT ###

2.times do 
    OrderProduct.create(product_id: Product.all.sample.id, order_id: order1.id)
end

3.times do 
    OrderProduct.create(product_id: desk.id, order_id: order3.id)
end

binding.pry