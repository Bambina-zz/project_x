# coding: utf-8
class TasksController < ApplicationController
  before_action :set_task, only: %i(edit show destroy)

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new(errand_id: params[:errand_id])
    #TODO: params[:task]ないときのエラー動作を考える
    # EX: redirect_to(:back)またはトップにリダイレクトetc...
  end

  def create
    @task = Task.new(task_params)
    @task.errand_id = params[:errand_id]

    if @task.save
    else
      render json: { task: @task.errors }, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
    else
      render json: { task: @task.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :errand_id, :done)
  end
end
