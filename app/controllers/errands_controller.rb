class ErrandsController < ApplicationController
  def index
    @errands = Errand.all
  end

  def new
    @errand = Errand.new
  end
  
  def create
    @errand = Errand.new(errand_params)
 
    if @errand.save
      redirect_to @errand
    else
      render 'new'
    end
  end
  
  def edit
    @errand = Errand.find(params[:id])
  end
  
  def show
    @errand = Errand.find(params[:id])
  end
  
  def update
    @errand = Errand.find(params[:id])
 
    if @errand.update(errand_params)
      redirect_to @errand
    else
      render 'edit'
    end
  end

  def destroy
    @errand = Errand.find(params[:id]).destroy

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
