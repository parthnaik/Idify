before '/categories*' do
  unless session[:user_id]
    @errors = 'You need to be logged in to view that'
    request.path_info = '/'
  end
end

get '/' do
  # render login and signup page
  if session[:user_id]
    redirect '/categories'
  else
    erb :index
  end
end

#----------- USERS -----------

post '/sign_up' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  
  redirect '/categories'
end

post '/login' do
  user = User.find_by_email(params[:email])

  if user && User.authenticate(params[:email], params[:password])
    session[:user_id] = user.id
    redirect '/categories'
  else
    session[:login_error] = 'Invalid Login. Please try again!'
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/profile' do
  @my_ideas = Idea.where(user_id: session[:user_id])
  @my_voted_ideas = current_user.voted_ideas
  erb :profile
end

#----------- CATEGORIES -----------

get '/categories' do # displays all categories
  @categories = Category.all
  erb :categories
end

#----------- IDEAS -----------
get '/categories/:id' do # displays all ideas in a particular category
  @category_id = params[:id]
  ideas = Category.find_by_id(params[:id]).ideas
  @ideas_with_vote_count = []
  ideas.each { |idea| @ideas_with_vote_count << { idea: idea, vote_count: idea.votes.count } }
  @ideas_with_vote_count.sort_by! { |idea_hash| idea_hash[:vote_count] }.reverse!
  erb :ideas
end

get '/categories/:id/ideas/new' do
  erb :new
end

get '/categories/:cat_id/ideas/:idea_id' do # displays particular idea
  ideas = Category.find_by_id(params[:cat_id]).ideas
  @idea = ideas.find_by_id(params[:idea_id])
  @images = @idea.images
  erb :idea
end

post '/ideas' do
  idea = Idea.create(title: params[:new_idea][:title], description: params[:new_idea][:description], user_id: current_user.id, category_id: params[:cat_id])
  Image.create(url: params[:image][:url1], idea_id: idea.id)
  Image.create(url: params[:image][:url2], idea_id: idea.id)
  redirect '/categories/' + params[:cat_id]
end

#----------- VOTES -----------
post '/upvote' do
  existing_vote = Vote.where(idea_id: params['ideaId'], voter_id: session[:user_id])

  if existing_vote.count == 0
    Vote.create(idea_id: params['ideaId'], voter_id: session[:user_id])
    Idea.find(params['ideaId']).votes.count.to_s
  end
end