class Admin::InstructorsController < AdminController
  before_action :authenticate

  def index
    @instructors = Instructor.paginate(:page => params[:page])
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to admin_instructors_path
    else
      redirect new_admin_instructor_path
    end
  end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
    if @instructor.update(instructor_params)
      redirect_to admin_instructors_path
    else
      redirect edit_admin_instructor_path(@instructor)
    end
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def destroy
    @instructor = Instructor.find(params[:id])
    if @instructor.destroy
      redirect_to admin_instructors_path
    else
      redirect_to admin_instructors_path
    end
  end

  protected

  def instructor_params
    params.require(:instructor).permit(:name, :lastname, :biography, :avatar)
  end

end
