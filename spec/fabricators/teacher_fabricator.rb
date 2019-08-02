Fabricator(:teacher) do
  full_name {Faker::Name.name}
  phone {Faker::PhoneNumber.phone_number_with_country_code}
  email {Faker::Internet.email}
end 