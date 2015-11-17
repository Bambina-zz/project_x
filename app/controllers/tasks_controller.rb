# coding: utf-8
class TasksController < ApplicationController
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
      redirect_to @task.errand
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to errand_task_path
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to errand_url(@task.errand) }
      format.json { head :no_content }
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :errand_id)
    end
end
