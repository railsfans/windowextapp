class UsersController < ApplicationController
layout false
    def avatars
    @user = User.find(params[:id])
    style = params[:style] ? params[:style] : 'original'
    send_file @user.avatar.path(style),
              :type => @user.avatar_content_type
  end
	def index
	@users=User.all
	end
	def new
	@user = User.new
	respond_to do |format|
		format.html
		format.js
	end
	end
	
	def create
	@user = User.create( params[:user] )
	@user.save 
	redirect_to :action => :index
	end
	
	def show 
	@user=User.find(params[:id])
	end
	def destroy
	@user = User.find(params[:id])
	@user.avatar = nil
	@user.save
	
	redirect_to :action => :index
	end
	def edit
	@user=User.find(params[:id])
	end
	
	def update
	
	@user = User.find(params[:id])
	@user.update_attributes(params[:user])
	
	redirect_to :action => :show, :id => @user
	end
end
