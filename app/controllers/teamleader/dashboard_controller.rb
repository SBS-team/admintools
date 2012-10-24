class Teamleader::DashboardController < Teamleader::AppTeamleaderController
  def index
    authorize! :look, :dashboard

    @without_job = User.out_of_work

    @last_logs = UserChange.includes([:editor,:edited]).order('user_changes.created_at DESC').limit 10
    if current_user.is_teamleader?
      @last_logs = UserChange.subordinates(current_user).order('user_changes.created_at DESC').limit 10
    end

    @absents = Absent.actual_absents(Time.zone.now.midnight.to_s(:db))
    if current_user.is_teamleader?
      @absents = User.subordinates(@absents, current_user)
    end

    start = Time.now
    finish = Time.now + 2.week
    @birthdays = User.select do |u|
      date_from = Date.parse("#{u.birthday.day}-#{u.birthday.month}-#{start.year}")
      date_to = Date.parse("#{u.birthday.day}-#{u.birthday.month}-#{finish.year}")
      ((date_from >= start.to_date) && (date_from < finish.to_date))||((date_to >= start.to_date) && (date_to < finish.to_date))
    end
  end
end