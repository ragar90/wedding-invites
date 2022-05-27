# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
numbers = [1,2,3,4,5,6,7,8,9,0]
country_codes = {"El Salvador" => "+503", "Estados Unidos" => "+1", "Panama" => "+507", "Australia" => "+61", "Guatemala" => "+502"}
(1..50).each do |i|
    g = Guest.create(
        name: "Guest",
        lastname: " #{i}",
        phone_number: "#{country_codes.to_a.sample[1]}#{numbers.sample(10).join}" 
    )
    if(i % 3 == 0)
        Guest.create(
            name: "Guest",
            lastname: " #{i}-1",
            parent_guest_id: g.id
        )
        Guest.create(
            name: "Guest",
            lastname: " #{i}-2",
            parent_guest_id: g.id
        )
        Guest.create(
            name: "Guest",
            lastname: " #{i}-3",
            parent_guest_id: g.id
        )
    end
end