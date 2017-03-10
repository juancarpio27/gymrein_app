class Api::V1::InstructorsController < Api::ApiController

  before_action :assert_user

  def show
    @instructor = Instructor.find(params[:id])
    render json: @instructor.as_json(methods: [:avatar_url])
  end

end
