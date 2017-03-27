class Admin::InstructorClassDatesController < AdminController
  before_action :authenticate
  before_action :load_instructor

  def index
    @class_dates = @instructor.class_dates.where('date > ?', Time.now - 6.hours).order('class_dates.date DESC').paginate(:page => params[:page])
  end

  protected

  def load_instructor
    @instructor = Instructor.find(params[:instructor_id])
  end
end
