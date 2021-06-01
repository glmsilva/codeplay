class CoursesController < ApplicationController

  def index
    @courses = Course.where(enrollment_deadline: Date.today..)
  end

  def show
    @course = Course.friendly.find(params[:id])
  end

  def enroll
    @course = Course.friendly.find(params[:id])
    current_user.enrollments.create(course: @course, price: @course.price)
    redirect_to my_courses_courses_path, notice: 'Curso comprado com sucesso'
  end

  def my_courses
    @enrollments = current_user.enrollments
  end
end