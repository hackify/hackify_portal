class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    #store user in redis
    cookies["_validation_token_key"] = Digest::MD5.hexdigest("#{session[:session_id]}:#{user.id}")
    # store session data or any authentication data you want here, generate to JSON data
    stored_session = JSON.generate({"provider"=> user.provider, "uid"=>user.uid,  "name"=>user.name, "email"=>user.email, "image"=>user.image})
    $redis.hset(
      "mySessionStore",
      cookies["_validation_token_key"],
      stored_session,
     )    

    redirect_back_or_default root_url
  end

  def destroy
    session[:user_id] = nil

    #expire session in redis
    if cookies["_validation_token_key"].present?
      $redis.hdel("mySessionStore", cookies["_validation_token_key"])
    end
    
    redirect_to root_url, notice: "Signed out!"
  end

  def login
    session[:return_to] = request.referrer  #for volantary login, redirect back to the original page
  end

  private

  def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
  end  
end