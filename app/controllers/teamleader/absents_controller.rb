class Teamleader::AbsentsController < Teamleader::AppTeamleaderController
  def index
    @absents = current_user.absents
  end

  def new
    @absent = Absent.new
  end

  def create
    @absent = current_user.absents.build(params[:absent])
    if @absent.save
      redirect_to teamleader_absents_path
      AbsentMailer.send_absent_mail(@absent).deliver
    else
      render :new
    end
  end

  def destroy
   @absent = Absent.find(params[:id]).destroy()
   redirect_to teamleader_absents_path
  end
end