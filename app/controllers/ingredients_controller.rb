class IngredientsController < ApplicationController
    before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
    before_action :require_admin, except: [:index, :show]

    def index
        @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
    end
    
    def show
        @ingredient_recipes = @ingredient.recipe.paginate(page: params[:page], per_page: 5)
    end
    
    def create
        @ingredient = Ingredient.new(ingredient_params)
        if @ingredient.save
            flash[:success] = "Create ingredient successfully"   
            redirect_to ingredient_path(@ingredient)
        else 
            render 'new'
        end
    end
    
    def update
        if @ingredient.update(ingredient_params)
            flash[:success] = "Update ingredient successfully"
            redirect_to @ingredient
        else
            render 'edit'
        end
    end
    
    def new
        @ingredient = Ingredient.new
    end
    
    def edit
    
    end
    
    def destroy
        Ingredient.find(params[:id]).destroy
        flash[:danger] = "Ingredient was delete successfully"
        redirect_to ingredients_path
    end
    
    private 
        def set_ingredient
           @ingredient = Ingredient.find(params[:id]) 
        end
        
        def ingredient_params
           params.require(:ingredient).permit(:name)
        end
        def require_admin
            if !logged_in? && (logged_in? and !current_chef.admin?)
                flash[:danger] = "Only admin users can action"
                redirect_to ingredient_path
            end
        end
end