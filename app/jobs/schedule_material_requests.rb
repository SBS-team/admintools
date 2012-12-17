class ScheduleMaterialRequests
  @queue = :shedule_material_requests

  def self.perform
    MaterialRequest.unconfirmed.each do |material_request|
      MaterialRequestMailer.send_material_request(material_request)
    end
  end
end