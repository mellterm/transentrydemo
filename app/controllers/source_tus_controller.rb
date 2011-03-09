class SourceTusController < ApplicationController
  def index
    @source_tus = SourceTu.all
  end

  def show
    @source_tu = SourceTu.find(params[:id])
  end

  def new
    @source_tu = SourceTu.new
  end

  def create
    @source_tu = SourceTu.new(params[:source_tu])
    if @source_tu.save
      redirect_to @source_tu, :notice => "Successfully created source tu."
    else
      render :action => 'new'
    end
  end

  def edit
    @source_tu = SourceTu.find(params[:id])
  end

  def update
    @source_tu = SourceTu.find(params[:id])
    if @source_tu.update_attributes(params[:source_tu])
      redirect_to @source_tu, :notice  => "Successfully updated source tu."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @source_tu = SourceTu.find(params[:id])
    @source_tu.destroy
    redirect_to source_tus_url, :notice => "Successfully destroyed source tu."
  end
end
