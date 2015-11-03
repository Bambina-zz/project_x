class ErrandsController < ApplicationController
  def index
    @errands = current_user.errands
  end

  def new
    @errand = current_user.errands.new
  end

  def create
    @errand = current_user.errands.new(errand_params)

    if @errand.save
      redirect_to @errand
    else
      render 'new'
    end
  end

  def edit
    @errand = current_user.errands.find(params[:id])
  end

  def show
    @errand = current_user.errands.find(params[:id])
  end

  def update
    @errand = current_user.errands.find(params[:id])

    if @errand.update(errand_params)
      redirect_to @errand
    else
      render 'edit'
    end
  end

  def destroy
    @errand = current_user.errands.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to errands_url }
      format.json { head :no_content }
    end
  end

  private
    def errand_params
      params.require(:errand).permit(:name)
    end
end
