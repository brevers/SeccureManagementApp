class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_manager_or_above!, only: %i[ new create destroy ]

  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  before_action :ensure_department!

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks.accessible_to(current_user)
  end

  # GET projects/1/tasks/1
  def show
  end

  # GET projects/1/tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET projects/1/tasks/1/edit
  def edit
  end

  # POST projects/1/tasks
  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to(@task.project)
    else
      render action: 'new'
    end
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update(task_params)
      redirect_to(@task.project)
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy

    redirect_to @project
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.organization.projects.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
      set_current_task(@task)
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id, :department)
    end
end
