module Admin
  class CoursesController < AdminController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @instructors = Instructor.where(status: 0)
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_course_path(@course)
    else
      @instructors = Instructor.where(status: 0)
      render :new
    end
  end

  def edit
    @instructors = Instructor.where(status: 0)
  end

  def update
    @course.update(course_params)
    redirect_to admin_course_path(@course), notice: t('.success')
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: 'Curso apagado com sucesso'
  end

    private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params
      .require(:course)
      .permit(:name, :description, :code, :price, :instructor_id,
              :enrollment_deadline, :banner)
  end
  end
end