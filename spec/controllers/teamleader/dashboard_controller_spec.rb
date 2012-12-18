require 'spec_helper'

describe Teamleader::DashboardController do

end

#
#class Teamleader::DashboardController < Teamleader::AppTeamleaderController
#  def index
#
#
#    @without_job = User.out_of_work
#
#    @last_logs = UserChange.includes([:editor,:edited]).order('user_changes.created_at DESC').limit 10
#    if current_user.is_teamleader?
#      @last_logs = UserChange.subordinates(current_user).order('user_changes.created_at DESC').limit 10
#    end
#
#    @absents = Absent.actual_absents(Time.zone.now.midnight.to_s(:db))
#    if current_user.is_teamleader?
#      @absents = User.subordinates(@absents, current_user)
#    end
#    if current_user.is_user?
#      @polls = Poll.order("created_at DESC")
#    end
#
#    #@last_logs = if current_user.is_teamleader?
#    #               UserChange.subordinates(current_user)
#    #             else
#    #               UserChange.includes([:editor,:edited])
#    #             end.order('user_changes.created_at DESC').limit 10
#    #
#    #@absents = if current_user.is_teamleader?
#    #             User.subordinates(@absents, current_user)
#    #           else
#    #             Absent.actual_absents(Time.zone.now.midnight.to_s(:db))
#    #           end
#    #
#    #@polls = Poll.order("created_at DESC") if current_user.is_user?
#
#    start = Time.now
#    finish = Time.now + 2.week
#    @birthdays = User.select do |u|
#      if u.birthday
#        date_from = Date.parse("#{u.birthday.day}-#{u.birthday.month}-#{start.year}")
#        date_to = Date.parse("#{u.birthday.day}-#{u.birthday.month}-#{finish.year}")
#        ((date_from >= start.to_date) && (date_from < finish.to_date))||((date_to >= start.to_date) && (date_to < finish.to_date))
#      end
#    end
#  end
#end