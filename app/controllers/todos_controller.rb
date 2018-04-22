class TodosController < ApplicationController
  def index
    table = Todo.arel_table
    @todos = Todo.where(table[:is_public].eq(true).or(table[:user_id].eq(current_user.id)))
    json_response(@todos)
  end

  def show
    table = Todo.arel_table
    available_todos = Todo.where(table[:is_public].eq(true).or(table[:user_id].eq(current_user.id)))
    @todo = available_todos.find_by!(:id => params[:id])
    json_response(@todo)
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  def update
    @todo = current_user.todos.find_by!(:id => params[:id])
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo = current_user.todos.find_by!(:id => params[:id])
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title, :public)
  end
end
