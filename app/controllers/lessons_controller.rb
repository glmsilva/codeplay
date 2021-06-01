class LessonsController < ApplicationController
  before_action :set_course, only: %i[index show]

  def index
    @lessons = Lesson.where(course_id: params[:course_id])
  end

  def show
    @lesson = Lesson.friendly.find(params[:id])
  end

    private

  def set_course
    @course = Course.friendly.find(params[:course_id])

  end
end