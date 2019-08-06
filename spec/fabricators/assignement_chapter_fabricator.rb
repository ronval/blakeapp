Fabricator(:assignment_chapter) do
  assignment_id(1)
  answer(Faker::Lorem.sentence)
  content(Faker::Lorem.sentence)
end 

