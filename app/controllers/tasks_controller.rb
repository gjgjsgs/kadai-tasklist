class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
    
  def index
    if logged_in?
      @tasks = current_user.task.order(id: :desc)
  
    end
    
  end
    
  def show
    set_task
  end
    
  def new
    @task = Task.new
  end

  def create
    @task = current_user.task.build(task_params)
    
    if @task.save
      flash[:success] = '正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = '投稿されませんでした'
      render :new
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = '正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
   @task_login_user.destroy
    
    flash[:success] = '正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end  
  
  def correct_user
    @task_login_user = current_user.task.find_by(id: params[:id])
    unless @task_login_user
      redirect_to root_url
    end
  end
end
