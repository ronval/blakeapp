# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Teacher.create(full_name:"Mr Rogers", phone:"1234567890", email:"mr.rogers@email.com")
Teacher.create(full_name:"Yoda", phone:"1234567890", email:"yoda@email.com")
Teacher.create(full_name:"Big Bird", phone:"1234567890", email:"big.bird@email.com")
teacher = Teacher.create(full_name:"Count Dracula", phone:"1234567890", email:"count.dracula@email.com")


subject = Subject.create(name:"Math", teacher_id:teacher.id, school_year:"2019/2020")

Lesson.create(subject_id:subject.id, name:"Addition", sections_attributes:{"1565174625072"=>{"content"=>"2+2", "_destroy"=>"false"}, "1565174629713"=>{"content"=>"3+3", "_destroy"=>"false"}, "0"=>{"content"=>"1+1", "_destroy"=>"false"}})
Lesson.create(subject_id:subject.id, name:"Subtraction", sections_attributes:{"1565174625072"=>{"content"=>"1-2", "_destroy"=>"false"}, "1565174629713"=>{"content"=>"3-3", "_destroy"=>"false"}, "0"=>{"content"=>"1-10", "_destroy"=>"false"}})
Lesson.create(subject_id:subject.id, name:"Multiplication", sections_attributes:{"1565174625072"=>{"content"=>"1x2", "_destroy"=>"false"}, "1565174629713"=>{"content"=>"3x3", "_destroy"=>"false"}, "0"=>{"content"=>"1x10", "_destroy"=>"false"}})

student = Student.create(full_name:"Johny Smith", email:"john@email.com")
Enrollment.create(student_id:student.id, subject_id:subject.id)
      lessons = Lesson.where(subject_id:subject.id)
      lessons.each do |lesson|
        assignment = Assignment.create(student_id:student.id, lesson_id:lesson.id, subject_id:subject.id)
        lesson.sections.each do |section|
          AssignmentChapter.create(assignment_id:assignment.id, content:section.content)
        end
      end
        
      Assignment.where(student_id:student.id, subject_id:subject.id).first.update_columns(accessible:true)