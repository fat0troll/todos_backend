class TasksController < ApplicationController
  before_action :set_objects

  def index
    json_response(@todo.tasks)
  end

  def show
    json_response(@task)
  end

  def create
    @todo.tasks.create!(task_params)
    json_response(@todo, :created)
  end

  def update
    @task.update(task_params)
    head :no_content
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_params
    params.permit(:name, :done)
  end

  def set_objects
    @todo = Todo.find(params[:todo_id])
    if !params[:id].blank? && !@todo.blank?
      @task = @todo.tasks.find_by!(:id => params[:id])
    end
  end
end
