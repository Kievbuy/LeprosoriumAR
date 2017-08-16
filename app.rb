require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog.db'

class Post < ActiveRecord::Base
  validates :author, presence: true
  validates :content, presence: true
end

class Comment < ActiveRecord::Base
end

get '/' do
  @posts = Post.order('created_at DESC')
  erb :index
end

get '/new' do
  @p = Post.new
  erb :new
end

get '/post/:id' do
  @post = Post.find(params[:id])

  @comments = Comment.all

  erb :post
end



# ==== POST ====

post '/new' do
  @p = Post.new params[:post]
  if @p.save
    erb "<h2>Спасибо. Ваш пост добавлен.</h2>"
  else
    @error = @p.errors.full_messages.first
    erb :new
  end
end

post '/post/:id' do
  @comment = Comment.new params[:comm]
  if @comment.save
    erb '<h2>Your comment added. Thank you.</h2>'
  else
    @posterror = @comment.errors.full_messages.first
    erb :post
  end
end