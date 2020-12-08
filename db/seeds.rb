
User.destroy_all
Vendor.destroy_all
Product.destroy_all
Order.destroy_all
OrderProduct.destroy_all

### USER ###

bill = User.create(username: "Billy", password: "abc123")
mark = User.create(username: "Marky", password: "abc123")
kate = User.create(username: "Katie", password: "abc123")
jon = User.create(username: "Jonny", password: "abc123")
sarah = User.create(username: "Sarah", password: "abc123")


### VENDOR ###

ble = Vendor.create(name: "BL Electronics")
li = Vendor.create(name: "Luxe Interiors")
fresh = Vendor.create(name: "Fresh")


### ORDER ###

order1 = Order.create(user_id: bill.id, date: "June 1", amount: 500, completed: true)
order2 = Order.create(user_id: kate.id, date: "May 1", completed: true)
order3 = Order.create(user_id: sarah.id, date: "Jan 1", completed: false)
order4 = Order.create(user_id: bill.id, date: "July 3", amount: 300, completed: true)
order5 = Order.create(user_id: mark.id, date: "March 3", completed: true)
order6 = Order.create(user_id: sarah.id, date: "Jan 1", completed: false)


### PRODUCT ###

monitor = Product.create(name: "Monitor 22", vendor_id: ble.id, price: rand(100))
mouse = Product.create(name: "Bluetooth Mouse", vendor_id: ble.id, price: rand(50))
keyboard = Product.create(name: "Bluetooth Keyboard", vendor_id: ble.id, price: rand(200))
sofa = Product.create(name: "Sofa", vendor_id: li.id, price: rand(2000))
desk = Product.create(name: "Desk", vendor_id: li.id, price: rand(2000))
desk_chair = Product.create(name: "Desk Chair", vendor_id: li.id, price: rand(500))
milk = Product.create(name: "Milk 1L", vendor_id: fresh.id, price: rand(5))
cheese = Product.create(name: "Brie Cheese", vendor_id: fresh.id, price: rand(20))
eggs = Product.create(name: "Carton of Eggs", vendor_id: fresh.id, price: rand(5))
butter = Product.create(name: "Butter", vendor_id: fresh.id, price: rand(5))



### ORDER_PRODUCT ###
# OrderProduct.create(product_id:  Product.all.sample.id, order_id: order6.id)
# 2.times do 
#     OrderProduct.create(product_id: Product.all.sample.id, order_id: order1.id)
# end

# 3.times do 
#     OrderProduct.create(product_id: desk.id, order_id: order3.id)
# end
