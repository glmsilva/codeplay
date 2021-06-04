module Admin
  class CoursesController < AdminController
    before_action :set_course, only: %i[show edit update destroy publish]

    def index
      @courses = Course.where(status: :published)
    end

    def show
    end

    def new
      @instructors = Instructor.where(status: :active)
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      @course.status = params[:status]
      if @course.save
        redirect_to admin_course_path(@course)
      else
        @instructors = Instructor.where(status: :active)
        render :new
      end
    end

    def edit
      @instructors = Instructor.where(status: :active)
    end

    def update
      @course.update(course_params)
      redirect_to admin_course_path(@course), notice: t('.success')
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: 'Curso apagado com sucesso'
    end

    def drafts
      @courses = Course.where(status: 1)
    end

    def publish
      @course.published!
      redirect_to admin_course_path(@course), notice: 'Atualizado com sucesso'
    end

    def enrollments 
      @enrollments = Enrollment.all
    end

    private

    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      params
        .require(:course)
        .permit(:name, :description, :code, :price, :instructor_id,
                :enrollment_deadline, :status, :category, :banner)
    end
  end
end
