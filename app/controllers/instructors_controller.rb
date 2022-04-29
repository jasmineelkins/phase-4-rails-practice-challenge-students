class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  # GET /instructors
  def index
    instructors = Instructor.all
    render json: instructors
  end

  # GET /instructors/:id
  def show
    instructor = find_instructor
    render json: instructor
  end

  # POST /instructors
  def create
    new_instructor = Instructor.create!(instructor_params)
    render json: new_instructor, status: :created
  end

  # UPDATE /instructors/:id
  def update
    instructor = find_instructor
    instructor.update!(instructor_params)
    render json: instructor
  end

  # DELETE /instructors/:id
  def destroy
    instructor = find_instructor
    instructor.destroy
    render json: {}
  end

  private

  def instructor_params
    params.permit(:name, :age, :major, :instructor_id)
  end

  def find_instructor
    Instructor.find_by!(id: params[:id])
  end

  def render_invalid_response(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
