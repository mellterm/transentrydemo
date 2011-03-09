class DomainMatricesController < ApplicationController
  def index
    @domain_matrices = DomainMatrix.all
  end

  def show
    @domain_matrix = DomainMatrix.find(params[:id])
  end

  def new
    @domain_matrix = DomainMatrix.new
  end

  def create
    @domain_matrix = DomainMatrix.new(params[:domain_matrix])
    if @domain_matrix.save
      redirect_to @domain_matrix, :notice => "Successfully created domain matrix."
    else
      render :action => 'new'
    end
  end

  def edit
    @domain_matrix = DomainMatrix.find(params[:id])
  end

  def update
    @domain_matrix = DomainMatrix.find(params[:id])
    if @domain_matrix.update_attributes(params[:domain_matrix])
      redirect_to @domain_matrix, :notice  => "Successfully updated domain matrix."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @domain_matrix = DomainMatrix.find(params[:id])
    @domain_matrix.destroy
    redirect_to domain_matrices_url, :notice => "Successfully destroyed domain matrix."
  end
end
