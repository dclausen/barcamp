class TalksController < ApplicationController
  before_filter :login_required, :except => :index

  def index    

    conditions = (params[:day] ? ["day = ?", params[:day]] : nil)
    @talks = Talk.all(:conditions => conditions, :include => :room, :with_deleted => true, :order => "day, start_time")

    respond_to do |format|      
      format.html 
      format.json 
    end
  end
  
  def new
    @talk = Talk.new
  end
  
  def create
    @talk = Talk.create(params[:talk])
    if @talk.save
      flash[:notice] = "Talk created"
      redirect_to talks_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @talk = Talk.find(params[:id])    
  end
  
  def update
    @talk = Talk.find(params[:id])
    @talk.update_attributes(params[:talk])
    if @talk.save
      flash[:notice] = "Talk updated"
      redirect_to root_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    Talk.destroy(params[:id])
    redirect_to root_path
  end
  
end