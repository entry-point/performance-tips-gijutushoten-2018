class StatusesController < ApplicationController
  def show
    current_status = CurrentStatus.new.execute
    @status = current_status[:status]
    @created_at = current_status[:created_at]
  end

  def create
    update_status = UpdateStatus.new(['ok', 'ng', 'waiting'].sample)
    update_status.execute
    redirect_to action: :show
  end
end
