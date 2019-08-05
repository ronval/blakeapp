Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'pages#home'
  get "ui_pages" => "ui_pages#index"
  get "ui_add_class" => "ui_pages#add_class", :as => :ui_add_class
  get "ui_add_teacher" => "ui_pages#add_teacher", :as => :ui_add_teacher
  get "ui_new_lesson" => "ui_pages#new_lesson", :as => :ui_create_lesson
  get "ui_edit_lesson" => "ui_pages#edit_lesson", :as => :ui_edit_lesson
  get "ui_add_student" => "ui_pages#add_student", :as => :ui_add_student
  get "ui_student_list" => "ui_pages#student_list", :as => :ui_student_index
  get "ui_grade_lesson" => "ui_pages#grade_lesson", :as=> :ui_grade_lesson
  post "lesson/start_lesson" =>"lessons#start_lesson", :as=> :start_lesson

  resources :subjects
  resources :teachers
  resources :lessons
  resources :students 
  resources :classes
  resources :assignment_chapters
  resources :class_rooms
  
end
