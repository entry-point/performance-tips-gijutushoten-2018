class UpdateStatus
  def initialize(status)
    @status = status
  end

  def execute
    sleep 15
    Status.create!(status: @status)
  end
end
