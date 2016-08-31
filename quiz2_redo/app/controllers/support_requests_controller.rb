class SupportRequestsController < ApplicationController

  before_action :find_request, only: [:edit, :update, :destroy]

  def new
    @support_request = SupportRequest.new
  end

  def create
    support_request_params = params.require(:support_request).permit(:name, :email, :department, :message, :status)
    @support_request = SupportRequest.new support_request_params
    if @support_request.save
      flash[:notice] = "Support request created!"
      redirect_to support_requests_path(@support_request)
    else
      render (:new)
    end
  end

  def show
    @support_request = SupportRequest.find params[:id]
  end

  def index
    @support_requests = SupportRequest.all
    if params[:search_item]
       @search_item = params[:search_item]
       @support_requests = SupportRequest.where(["name ILIKE ? OR email ILIKE ? OR department ILIKE ? OR message ILIKE ?", "%#{@search_item}%","%#{@search_item}%","%#{@search_item}%","%#{@search_item}%"]).page(params[:page])
     else
       @support_requests = SupportRequest.order("id DESC").page(params[:page])
     end

     if params[:id].to_i > 0
       @support_request = SupportRequest.find params[:id]
       @support_request.status == false ? @support_request.status = true : @support_request.status = false
       @support_request.save
    end

  end

  def edit
    @support_request = SupportRequest.find params[:id]
  end

  def update
    support_request_params = params.require(:support_request).permit(:name, :email, :department, :message, :status)
    @support_request       = SupportRequest.find params[:id]
    if @support_request.update support_request_params
      redirect_to support_request_path(@support_request)
    else
      render :edit
    end
  end

  def destroy
    support_request = SupportRequest.find params[:id]
    support_request.destroy
    redirect_to support_requests_path
    flash[:alert] = "Support Request deleted!"
  end

  private

  def find_request
    @support_request = SupportRequest.find params[:id]
  end



end
