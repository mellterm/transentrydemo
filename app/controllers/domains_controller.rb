class DomainsController < ApplicationController
  def index
    @domains = Domain.all
  end

  def show
    @domain = Domain.find(params[:id])
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      redirect_to @domain, :notice => "Successfully created domain."
    else
      render :action => 'new'
    end
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    if @domain.update_attributes(params[:domain])
      redirect_to @domain, :notice  => "Successfully updated domain."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy
    redirect_to domains_url, :notice => "Successfully destroyed domain."
  end
end
