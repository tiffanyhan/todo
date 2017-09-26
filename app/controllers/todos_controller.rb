class TodosController < ApplicationController
  def index
    if logged_in?
      @incomplete_todos = Todo.where(completed: false, user_id: current_user.id).order(due_date: :asc)
      @complete_todos = Todo.where(completed: true, user_id: current_user.id).order(due_date: :asc)
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash[:notice] = "You are getting baguettes"
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
      redirect_to todos_path
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
      flash[:notice] = "Generic error call Jay to fix."
      redirect_to todos_path
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date, :completed, :user_id)
  end
end
