module Admin
  class InstructorsController < AdminController
    def index
      @instructors = Instructor.where(status: 0 )

    end

    def show
      @instructor = Instructor.find(params[:id])
    end

    def new
      @instructor = Instructor.new
    end

    def create
      @instructor = Instructor.new(instructor_params)
      if @instructor.save
        redirect_to admin_instructor_path @instructor
      else
        render :new
      end
    end

    def edit
      @instructor = Instructor.find(params[:id])
    end

    def update
      @instructor = Instructor.find(params[:id])
      @instructor.update(instructor_params)

      redirect_to admin_instructor_path(@instructor), notice: 'Professor atualizado com sucesso'
    end

    def destroy
      @instructor = Instructor.find(params[:id])
      @instructor.destroy
      redirect_to admin_instructors_path, notice: 'Professor apagado com sucesso'
    end

    def show_inactive
      @inactive_instructors = Instructor.where(status: 1)
    end

    def active_instructor
      @instructor = Instructor.find(params[:id])
      @instructor.active!

      redirect_to admin_instructor_path(@instructor), notice: 'Professor ativado com sucesso'
    end

    def inactive_instructor
      @instructor = Instructor.find(params[:id])
      @instructor.inactive!
      redirect_to admin_instructors_path, notice: 'Professor inativado com sucesso'
    end

    private
    def instructor_params
      params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
    end
  end
end