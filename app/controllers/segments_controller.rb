class SegmentsController < ApplicationController
  def index
    @segments = Segment.all
  end

  def show
    @segment = Segment.find(params[:id])
  end

  def new
    @segment = Segment.new
  end

  def create
    @segment = Segment.new(params[:segment])
    if @segment.save
      redirect_to @segment, :notice => "Successfully created segment."
    else
      render :action => 'new'
    end
  end

  def edit
    @segment = Segment.find(params[:id])
  end

  def update
    @segment = Segment.find(params[:id])
    if @segment.update_attributes(params[:segment])
      redirect_to @segment, :notice  => "Successfully updated segment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @segment = Segment.find(params[:id])
    @segment.destroy
    redirect_to segments_url, :notice => "Successfully destroyed segment."
  end
end
