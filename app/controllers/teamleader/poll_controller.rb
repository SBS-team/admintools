class Teamleader::PollController < Teamleader::AppTeamleaderController
  helper_method :total_voted, :opt_voted, :voted_set
  before_filter :init_poll, :only => :destroy
  def opt_voted(opt,i,poll)
    poll.voteds.find_all_by_option_vote_and_option_id(opt, i+1).count
  end

  def total_voted(poll)
    poll.voteds
  end

  def voted_set(poll)
    poll.voteds.find_by_user_id(current_user.id)
  end

  def index
    @polls = Poll.order("created_at DESC")
  # authorize! :read, @polls
  end

  def new
    @poll = Poll.new
  end

  def create
    if !params['poll']['question'].blank? && params['poll']['max_votes'].to_i > 0 && params['poll']['option'].delete_if { |x| x == "" }.count > 1
      @poll = current_user.polls.build(params['poll'])
      @poll.update_attribute(:end_at, 1.day.from_now) if @poll.end_at < DateTime.now
      PollMailer.send_poll_mail(@poll,current_user).deliver
      redirect_to teamleader_poll_index_path
    else
      flash[:alert] = t(:'teamleader.poll.create.invalid')
      redirect_to new_teamleader_poll_path
    end
  end

  def show
    redirect_to teamleader_poll_index_path if (@poll = Poll.find_by_id(params['id'])).blank?
  end

  def voted
    if (@poll = Poll.find_by_id(params['id'])).blank?
      redirect_to teamleader_poll_index_path
    else
      if !params['option'].blank? && params['option'].count <= @poll.max_votes
        params['option'].each do |opt|
          @voted = Voted.find_or_create_by_user_id_and_poll_id_and_option_vote_and_option_id(:user_id => current_user.id, :poll_id => @poll.id, :option_vote => opt.last["name"], :option_id => opt.first.to_i+1)
        end
      else
        flash[:alert] = t(:'teamleader.poll.voted.invalid')
      end
      redirect_to teamleader_poll_path(@poll)
    end
  end

  def destroy
    @poll.destroy and redirect_to :teamleader_poll_index, notice: t(:'teamleader.poll.destroy.destroyed', question: @poll.question)
  end

  private

  def init_poll
    @poll = Poll.find(params[:id])
  end
end