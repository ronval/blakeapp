class LessonsController < ApplicationController
  def new
    @lesson = Lesson.new
    @lesson.sections.build
    @subjects = Subject.all
  end

  def index
    @lessons = Lesson.where(subject_id:params[:subject_id])
  end

  def create
    @lesson = Lesson.new(lesson_params)
    
    @subjects = Subject.all
    if @lesson.save
      if @lesson.subject.students.any?
        students = @lesson.subject.students
        students.each do |student|
          assignment = Assignment.create(student_id:student.id, lesson_id:@lesson.id, subject_id:params[:lesson][:subject_id])
          @lesson.sections.each do |section|
            AssignmentChapter.create(assignment_id:assignment.id, content:section.content)
          end
        end 
      end

      flash[:success] = "You have created a new lesson."
      redirect_to new_lesson_path
    else
      render :new
    end 
  end


  def edit
    @lesson = Lesson.find_by(id:params[:id])
    @subjects = Subject.all
  end


  def update
    @lesson = Lesson.find_by(id:params[:id])
    @subjects = Subject.all
    if @lesson.update(lesson_params)
      flash[:success] = "You have updated the lesson."
      redirect_to edit_lesson_path(@lesson)
    else
      render :edit
    end 
  end

  def start_lesson
    assignment_chapter = AssignmentChapter.find_by(id:params[:assignment_chapter_id])
    assignment_chapter.update_columns(accessible:true)
    flash[:success] = "You can now start the section"
    redirect_to class_path(id:params[:subject_id])
  end

  private

  def lesson_params
    params.require(:lesson).permit(:subject_id, :name, sections_attributes:[:id, :_destroy, :content])
  end
end 