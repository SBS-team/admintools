class SargController < ApplicationController

  def index
    @indexes = ['/sarg_dir/Monthly/index.html','/sarg_dir/Weekly/index.html','/sarg_dir/Daily/index.html']
  end

end
