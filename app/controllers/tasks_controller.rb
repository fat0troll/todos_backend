class TasksController < ApplicationController
  before_action :set_objects
  skip_before_action :set_objects, only: :destroy

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
    @todo = current_user.todos.find_by!(:id => params[:todo_id])
    @task = @todo.tasks.find_by!(:id => params[:id])
    @task.destroy
    head :no_content
  end

  private

  def task_params
    params.permit(:name, :done)
  end

  def set_objects
    table = Todo.arel_table
    available_todos = Todo.where(table[:public].eq(true).or(table[:user_id].eq(current_user.id)))
    @todo = available_todos.find(params[:todo_id])
    if !params[:id].blank? && !@todo.blank?
      @task = @todo.tasks.find_by!(:id => params[:id])
    end
  end
end
