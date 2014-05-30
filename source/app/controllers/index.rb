get '/' do
  # render login and signup page
  erb :index
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.create(params[:user])
  erb :sign_up
end

post '/sign_up' do
  @user = User.create(params[:user])
  session[:user_id] = @user.id
  
  redirect '/'
end

post '/login' do
@user = User.find_by_email(params[:email])
 if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
  end
  redirect '/'
end

get '/logout' do
  session.clear
  redirect to('/')
end
