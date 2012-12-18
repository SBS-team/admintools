class AddTeamleaderReportIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :teamleader_report_id, :integer
  end
end
