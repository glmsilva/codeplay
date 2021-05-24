class LessonsController < ApplicationController
  def index
    @lessons = Lesson.where(course_id: params[:course_id])
  end

  def new

  end

  def create

  end
end