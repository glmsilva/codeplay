class LessonsController < ApplicationController


  def index
    @course = Course.friendly.find(params[:course_id])
    @lessons = Lesson.where(course_id: params[:course_id])
  end

  def show
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.friendly.find(params[:id])
  end

  def attend_lesson
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.friendly.find(params[:id])
    current_user.attend_lesson.create(lesson: @lesson)
    redirect_to course_lesson_path(@course, @lesson)
  end

    private

  def set_course
    @course = Course.friendly.find(params[:course_id])

  end
end