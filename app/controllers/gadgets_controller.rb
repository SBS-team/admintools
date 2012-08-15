class GadgetsController < ApplicationController
  before_filter :init_vars, :only => [:new]

  def index
    @gadgets = Gadget.all
  end

  def new
    @gadget = Gadget.new
  end
  def create
    user = params[:user_id]

    @gadget = Gadget.new(params[:gadget])

    if(User.find_by_id(user))
      @gadget.user_id = user
      if @gadget.save
        redirect_to :gadgets
      else
        init_vars
        render :action => "new"
      end
    else
      init_vars
      render :action => "new"
    end

  end

  def edit
    @gadget = Desktop.find_by_id(params[:id])
  end

  def update
    @gadget = Desktop.find_by_id(params[:id])
    @gadget.update_attributes(params[:gadget]) ? (redirect_to :gadgets, notice: 'User updated') : (render :action => 'edit')
  end

  private
  def init_vars
    @user = User.all
  end

end
