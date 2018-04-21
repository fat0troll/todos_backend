class TodosController < ApplicationController
  def index
    @todos = Todo.all
    json_response(@todos)
  end

  def show
    @todo = Todo.find(params[:id])
    json_response(@todo)
  end

  def create
    @todo = Todo.create!(todo_params)
    json_response(@todo, :created)
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title, :user_id)
  end
end
