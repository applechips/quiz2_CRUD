class SupportRequestsController < ApplicationController
  def new
    @support_request = SupportRequest.new
  end

  def create
    support_request_params = params.require(:support_request).permit(:name, :email, :department, :message, :status)
    SupportRequest.create support_request_params
    if @support_request.save
      redirect_to request_path(@support_request)
      flash[:notice] = "Support request created!"
    else
      flash[:alert] = "Support request could not be created."
      render (:new)
    end
  end

end
