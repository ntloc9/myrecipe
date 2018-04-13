class SessionsController < ApplicationController
   def new
   
   end
   
   def create
      chef = Chef.find_by(email: params[:session][:email].downcase)
      if chef && chef.authenticate(params[:session][:password])
         session[:chef_id] = chef.id
         flash[:success] = "Login successfully"
         redirect_to chef
      else
         flash.now[:danger] = "There was something wrong with your login infomation"
         render 'new'
      end
   end
   
   def destroy
       session[:chef_id] = nil
       flash[:success] = "Logout successfully"
       redirect_to root_path
   end
end