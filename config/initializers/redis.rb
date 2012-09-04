$redis = Redis.new
# $redis.select 1
# (:host => 'localhost', :port => 6379)

# redis_count = $redis.get(:count).to_i
# $redis.set :count, redis_count ? $redis.smembers(:local_ping).length : 0
# Redis.current.set :count, 0

__END__

class asdasd
  def index

    @user = User.new
    #$redis.flushdb
    if ($redis.exists "users")
      @user_all = []
      ($redis.smembers "users").select{ |smember| (smember.to_i > 5000) && (smember.to_i < 6000) }.each do |smember|
         @user_all << $redis.hgetall(smember)
      end
      #@ss = $redis.hgetall
    end

    i = 5
  end

  def create
    #User.create! params[:user]
      $redis.incr "count_users"
      cur_id = $redis.get("count_users").to_i
      $redis.hmset cur_id, 'id', cur_id, 'name', params[:user][:name], 'lastname', params[:user][:lastname]
      #$redis.hmset cur_id,'id', cur_id, 'name', "User#{cur_id}", 'lastname', "Lamer#{cur_id}"
      $redis.sadd "users", cur_id


    redirect_to :root
  end



  def get_ver(*args)
    #(args.select{|v|!(v =~ /[a-zA-Z]/).nil?}.count == 1)? args.last : args.max
    (args.select{|v| v.match /[a-zA-Z]/}.size == 1) ? args.last : args.max
  end

  #         ["0.2.0.pre", "0.1.5"].max should return "0.1.5"
  #         ["0.2.0.pre", "0.2.0.pre.1"].max should return "0.2.0.pre.1"
  #         ["0.1.5", "0.2.0.pre"].max should return "0.2.0.pre"
  #         ["0.1.6", "0.1.1"].max should return "0.1.6"
  #(a[0]+a[1]).gsub(/pre/) {counter+=1}

end