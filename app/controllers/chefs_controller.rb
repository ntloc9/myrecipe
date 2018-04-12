class ChefsController < ApplicationController
    def index
        @chefs = Chef.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @chef = Chef.new
    end
    
    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Welcome #{@chef.chefname} to myrecipe app"
            redirect_to chef_path(@chef)
        else 
            render 'new'
        end
    end
    
    def show
        @chef = Chef.find(params[:id])
        @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
    end
    
    def destroy 
       @chef = Chef.find(params[:id])
       @chef.destroy
       flash[:danger] = "Chef and all recipes has been deleted"
       redirect_to chefs_path
    end
    

    private
    
    def chef_params
        params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)     
    end
            
    
end