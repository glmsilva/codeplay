class CoursesController < ApplicationController

  def index
    @courses = Course.where(enrollment_deadline: Date.today.., status: :published)
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

  def search
    @courses = Course.where("name LIKE :search AND enrollment_deadline >= :date",
                            search: "%#{params[:search]}%",
                            date: Date.today)
    if @courses.empty?
      flash[:alert] = 'Nada foi encontrado'
    end
  end
end