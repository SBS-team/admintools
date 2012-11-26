class Teamleader::VacationsController < Teamleader::AppTeamleaderController
  def show
    @users = User.includes(:vacations).all
    @year_list = (Vacation.select("YEAR(date_from) as year")+Vacation.select("YEAR(date_to) as year")).map {|v| v.year.to_s}.uniq.sort
    i =5
  end

  def update

  end
end