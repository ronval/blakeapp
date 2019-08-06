Fabricator(:student) do
  full_name {Faker::Name.name}
  email {Faker::Internet.email}
end 