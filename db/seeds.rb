# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ProcedureCategory.create([{code: 1, max_appointment_days: 30, max_postponment_days: 15},
                         {code: 2, max_appointment_days: 90, max_postponment_days: 45},
                         {code: 3, max_appointment_days: 365, max_postponment_days: 120}])
region = Region.create(name: 'Region Name')
hospital = Hospital.create(name: 'Hospital Name', region_id: region.id)
user = User.new(user_name: 'admin', hospital_id: hospital.id, full_name: 'Admin Admin', password: 'Admin123', role: User::ADMINISTRATOR)
user.save(validate: false)
