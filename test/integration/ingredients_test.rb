require 'test_helper'

class IngredientsTest < ActionDispatch::IntegrationTest
    test "create new ingredient" do
        get new_ingredient_path
    end
    
end
