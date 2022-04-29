class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  # GET /students
  def index
    students = Student.all
    render json: students
  end

  # GET /students/:id
  def show
    student = find_student
    render json: student
  end

  # POST /students
  def create
    new_student = Student.create!(student_params)
    render json: new_student, status: :created
  end

  # UPDATE /students/:id
  def update
    student = find_student
    student.update!(student_params)
    render json: student
  end

  # DELETE /students/:id
  def destroy
    student = find_student
    student.destroy
    render json: {}
  end

  private

  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end

  def find_student
    Student.find_by!(id: params[:id])
  end

  def render_invalid_response(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
