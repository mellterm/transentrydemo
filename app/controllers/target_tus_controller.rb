class TargetTusController < ApplicationController
  def index
    @target_tus = TargetTu.all
  end

  def show
    @target_tu = TargetTu.find(params[:id])
  end

  def new
    @target_tu = TargetTu.new
  end

  def create
    @target_tu = TargetTu.new(params[:target_tu])
    if @target_tu.save
      redirect_to @target_tu, :notice => "Successfully created target tu."
    else
      render :action => 'new'
    end
  end

  def edit
    @target_tu = TargetTu.find(params[:id])
  end

  def update
    @target_tu = TargetTu.find(params[:id])
    if @target_tu.update_attributes(params[:target_tu])
      redirect_to @target_tu, :notice  => "Successfully updated target tu."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @target_tu = TargetTu.find(params[:id])
    @target_tu.destroy
    redirect_to target_tus_url, :notice => "Successfully destroyed target tu."
  end
end
