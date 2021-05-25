module Admin
  class InstructorsController < ApplicationController
    def index
      @instructors = Instructor.all
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

    private
    def instructor_params
      params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
    end
  end
end