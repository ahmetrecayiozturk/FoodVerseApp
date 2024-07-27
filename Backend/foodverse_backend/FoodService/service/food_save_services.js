const SavedFoodModel = require('../model/food_save_model.js');
const UserModel = require('../../AuthService/model/user_model.js');

class FoodSaveService {
    static async saveFood(Id, name, ingredients, preparing) {
        try {
            const isuserexist = await UserModel.findOne({Id: Id})
            if(isuserexist){
                const savedFood = new SavedFoodModel({ Id: Id, name: name, ingredients: ingredients, preparing: preparing });
                await savedFood.save();
            }
            else{
                throw new Error("User not found")
            }
        } catch (error) {
            throw error;
        }
    }
    static async getSavedFood(Id) {
        try {
            return await SavedFoodModel.find({ Id: Id });
        } catch (error) {
            throw error;
        }
    }
}

module.exports = FoodSaveService;