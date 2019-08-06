Fabricator(:lesson) do
  subject_id(1)
  name {Faker::Educator.course_name}
  section

 
end