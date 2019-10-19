# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Schools
3.times do
  school = School.create!(
    name: "#{FFaker::Education.school_generic_name} High School"
  )

  # Create Teachers
  5.times do
    teacher = Teacher.create!(
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      school: school
    )

    # Create teacher account
    Account.create!(
      email: FFaker::Internet.safe_email,
      user: teacher
    )

    # Create Parents
    25.times do
      parent = Parent.create!(
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name
      )

      student = Student.create!(
        first_name: FFaker::Name.first_name,
        last_name: parent.last_name,
        teacher: teacher
      )

      StudentParent.create!(
        student: student,
        parent: parent
      )

      # Create parent accounts
      Account.create!(
        email: FFaker::Internet.safe_email,
        user: parent
      )
    end
  end
end
