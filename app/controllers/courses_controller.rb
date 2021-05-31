class CoursesController < ApplicationController
  def index
    @courses = Course.where('enrollment_deadline >= ?', Date.today)
  end

  def show
    @course = Course.friendly.find(params[:id])
  end

  def enroll
    @course = Course.friendly.find(params[:id])
    Enrollment.create(user: current_user, course: @course)
    redirect_to my_courses_courses_path, notice: 'Curso comprado com sucesso'
  end

  def my_courses
    @enrollments = current_user.enrollments

  end
end