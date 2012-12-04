class Teamleader::VacationsController < Teamleader::AppTeamleaderController
  def show
    @vacations = User.includes(:vacations).all.map(&:vacation_data)
    @year_list = (Vacation.select("YEAR(date_from) as year")+Vacation.select("YEAR(date_to) as year")).map {|v| v.year.to_s}.uniq.sort
  end

  def update

  end
end