class AsyncStatusesController < ApplicationController
  def show
    current_status = CurrentStatus.new.execute
    @status = current_status[:status]
    @created_at = current_status[:created_at]
    @notice = flash[:notice]
  end

  def create
    UpdateStatusJob.perform_later
    flash[:notice] = 'queuing!'

    redirect_to action: :show
  end
end
