# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
hospital = Hospital.create(name: 'Hospital Name')
user = User.new(user_name: 'admin', hospital_id: hospital.id, full_name: 'Admin Admin', password: 'Admin123', role: User::ADMINISTRATOR)
user.save(validate: false)
