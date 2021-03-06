class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def show
    id = params[:id]
    @task = Task.find(id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])

    if !@task.nil?
      if @task.update(task_params)
      # if @task.save
      redirect_to task_path(@task.id)
      else
        render :edit
      end
    else
      redirect_to tasks_path
    end
  end

  def destroy
    id = params[:id]
    @task = Task.find(id)
    if @task.destroy
      redirect_to tasks_path
    end
  end

  def mark_task_complete
    @task = Task.find_by(id: params[:id])
      # @task.status = "Complete"
      @task.status = Time.now
      @task.save
      redirect_to root_path
  end

  def mark_task_incomplete
    @task = Task.find_by(id: params[:id])
      @task.status = "Incomplete"
      @task.save
      redirect_to root_path
  end

private

def task_params
  return params.require(:task).permit(:task_name, :description, :completion_date, :status)
end

end
