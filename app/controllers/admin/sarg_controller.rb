class Admin::SargController < Admin::AppAdminController

  def index
  end

  def folder_create
    @from=params[:sarg_folder_path]
    @where="#{Rails.root}/public/sarg_dir"
    system"ln -s #{@from} #{@where}"
    redirect_to admin_sarg_index_path
  end
end