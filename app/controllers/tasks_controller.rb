class TasksController < ApplicationController
  before_action :set_project, except: [:complete_task, :update_positions]
  before_action :set_task, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @project, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete_task
    task = Task.find(params[:task_id])
    task.completed = !task.completed
    if task.save
      render status: 200, json: {
            success: true,
            completed: task.completed
      }.to_json
    end
  end

  def update_positions
    if params[:position] == 'down'
      Task.find(params[:current_row]).increment_position
    else
      Task.find(params[:current_row]).decrement_position
    end
    render status: 200, json: {
            success: true,
      }.to_json
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :due_date, :description, :completed)
    end
end



