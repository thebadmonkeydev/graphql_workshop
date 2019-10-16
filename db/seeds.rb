# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Schools
central = School.create!(
  name: 'Central High School'
)

# Create Teachers
teacher = Teacher.create!(
  first_name: 'Michael',
  last_name: 'Kelly',
  school: central
)

# Create teacher accounts
Account.create!(
  email: 'mkelly@example.com',
  user: teacher
)

# Create Parents
parent = Parent.create!(
  first_name: 'Danielle',
  last_name: 'Sullivan'
)

# Create parent accounts
Account.create!(
  email: 'dannie22@example.com',
  user: parent
)

# Create Students
