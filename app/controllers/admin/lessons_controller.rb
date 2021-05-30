module Admin
  class LessonsController < AdminController
    before_action :set_course, only: %i[new create destroy]

    def index
      @lessons = Lesson.where(course_id: params[:course_id])
    end

    def show
      @lesson = Lesson.find(params[:id])
    end

    def new
      @lesson = Lesson.new
    end

    def create
      @lesson = @course.lessons.new(lessons_params)
      if @lesson.save
        redirect_to admin_course_path(@course), notice: 'Aula cadastrada com sucesso'
      else
        render :new
      end
    end

    def edit
      @lesson = Lesson.find(params[:id])
    end

    def update
      @lesson = Lesson.find(params[:id])
      if @lesson.update(lessons_params)
        redirect_to admin_course_lesson_path(@lesson)
      else
        render :new
      end
    end

    def destroy
      @lesson = Lesson.find(params[:id])
      @lesson.destroy
      redirect_to admin_course_path(@lesson), notice: 'Aula apagada com sucesso'
    end

    private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def lessons_params
      params.require(:lesson).permit(:name, :content, :length)
    end
  end
end