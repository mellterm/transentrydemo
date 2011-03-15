class SegmentsController < ApplicationController

  
  def index
    @title = "Segments"
    @segments = Segment.all
   end
  
  def show
    @segment = Segment.find(params[:id])
  end
  
  def new
    @title = "New Segment"
    @segment = Segment.new
    @segment.user_id = 1
    @segment.updated_by = 1
  end
  
  def create
    @segment = Segment.new(params[:segment])
    @segment.user_id = 1
    @segment.updated_by = 1
    if @segment.save
      flash[:notice] = "Successfully created segment."
      redirect_to segments_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @segment = Segment.find(params[:id])
    @segment.updated_by = 1
    if @segment.document
      @title = "Editing Segment from #{@segment.document.data_file_name}"
    end
  end
  
  def update_ajax
    @segment = Segment.find(params[:id])
    if @segment.update_attributes(params[:segment])
      @segment.save
      respond_to do |format|
        format.js
      end
    end
  end
  
  def update
    @segment = Segment.find(params[:id])
    respond_to do |format|
      if @segment.update_attributes(params[:segment])
        
        @segment.save
        flash[:success] = "Successfully updated record."
        format.html { 
          if @segment.document
            redirect_to @segment.document
          else
            redirect_to @segment
          end
        }
        format.xml  { head :ok }
        format.js 
      else
        flash[:error] = "There was an error saving this record"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @segment.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end
  
  def destroy
    if params[:all]
      Segment.destroy_all
      flash[:success] = "Successfully delete all Segments from database."
    else
      @segment = Segment.find(params[:id])
      @segment.destroy
      flash[:success] = "Successfully deleted Segment."
    end
    redirect_to :action => "index"
  end
  
  
  def import
    # if params[:memory_file][:file]
    #   require 'hpricot'
    #   require 'tempfile'
    #   file = params[:memory_file][:file]
    #   #file = File.read("/tmp/utf8_SCHOLL_MARKETING.xml")
    #   
    #   user_id = nil
    #   user_id = current_user.id if current_user
    #   
    #   if params[:memory_file][:category_id]
    #     category_id = params[:memory_file][:category_id].to_i
    #   else
    #     category_id = nil
    #   end
    #   
    #   # Do the import job
    #   result = Segment.import_tmx(user_id,category_id,file)
    #   @total = result[:total]
    #   @rejected = result[:rejected]
    #   flash[:success] = "#{@total} entries were successfully imported."
    #   flash[:success] << "<br />#{@rejected} were not import." if (@rejected>0)
    #   flash[:notice] = result[:msg]
    #   file.close
    # else
    #   flash[:error] = "No File given"
    # end
    # redirect_to :action => "index"
  end
  
end
