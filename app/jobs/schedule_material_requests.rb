class ScheduleMaterialRequests
  @queue = :shedule_material_requests

  def self.perform
    MaterialRequestMailer.send_material_request(MaterialRequest.unprocessed).deliver
  end
end