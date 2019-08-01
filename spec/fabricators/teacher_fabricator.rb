Fabricator(:teacher) do
  full_name {Faker::Name.name}
  phone {Faker::PhoneNumber}
  email {Faker::Internet.email}
  teaches
end 