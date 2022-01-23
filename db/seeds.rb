# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#roles
buyer_role = Role.create(name: 'buyer')
seller_role = Role.create(name: 'seller')

# create buyer and seller users
seller = User.create(email: 'seller@example.com', password: '123123', password_confirmation: '123123',
                     roles: [seller_role])
buyer = User.create(email: 'buyer@example.com', password: '123123', password_confirmation: '123123',
                    roles: [buyer_role], deposit: 80)

# products
Product.create(seller: seller, name: 'Product 1', quantity: 5, cost: 10)
Product.create(seller: seller, name: 'Product 2', quantity: 2, cost: 30)
Product.create(seller: seller, name: 'Product 3', quantity: 15, cost: 80)
Product.create(seller: seller, name: 'Product 4', quantity: 25, cost: 5)

Product.create(seller: buyer, name: 'Product 5', quantity: 10, cost: 20)
