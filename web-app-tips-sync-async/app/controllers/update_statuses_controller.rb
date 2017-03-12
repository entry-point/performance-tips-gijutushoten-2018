class UpdateStatusesController < ApplicationController
  def show
    update_status = UpdateStatus.new(['ok', 'ng', 'waiting'].shuffle)
    update_status.execute
  end
end
