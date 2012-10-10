#encoding=UTF-8
class Admin::DomainsController < Admin::AppAdminController
  before_filter :current_domain, :only => [:show, :edit, :update, :destroy]

  def index
    @search = Domain.search(params[:search] || {"meta_sort" => 'active.desc'})
    @domains = @search.paginate(:page => params[:page]).order('created_at').all
  end

  def new
    @domain = Domain.new
  end

  def show

  end

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      redirect_to :admin_domains, :notice => "Домен #{@domain.url} добавлен"
    else
      render :action => "new"
    end
  end

  def update
    if @domain.update_attributes(params[:domain])
      redirect_to :admin_domains, :notice => "Домен #{@domain.url} обновлен"
    else
      render :action => "edit"
    end
  end

  def destroy
    @domain.destroy and redirect_to :admin_domains, :notice => "Домен #{@domain.url} удален"
  end

  private

  def current_domain
    @domain = Domain.find(params[:id])
  end
end
