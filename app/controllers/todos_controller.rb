class TodosController < ApplicationController
  def index
    @incomplete_todos = Todo.where(completed: false).order(due_date: :desc)
    @complete_todos = Todo.where(completed: true).order(due_date: :desc)
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      flash[:notice] = "You are getting baguettes" # todo fix this
      redirect_to todos_path
    else
      render "new"
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      flash[:notice] = "You added jelly to your baguette"
      redirect_to todo_path(@todo)
    else
      render "edit"
    end
  end

  def destroy
    @todo = Todo.find(params[:id])

    if @todo.destroy
      flash[:notice] = "You destroyed your sandwich"
      redirect_to todos_path
    else
      flash[:notice] = "The delete failed."
      redirect_to todos_path
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date)
  end
end