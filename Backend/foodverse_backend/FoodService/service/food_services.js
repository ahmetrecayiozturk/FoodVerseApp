const FoodModel = require('../model/food_model');

class FoodService {
    // Add a new food
    static async addFood(adder, name, ingredients, preparing, category) {
        try {
            const food = new FoodModel({ adder:adder, name: name, ingredients:ingredients, preparing:preparing, category: category });
            await food.save();
            return food;
        } catch (error) {
            throw error;
        }
    }

    // Get foods added by the user
    static async getAddedFoods(adder) {
        try {
            const foods = await FoodModel.find({ adder });
            return foods;
        } catch (error) {
            throw error;
        }
    }

    // Find foods by ingredients and category
    static async findFoodsByIngredients(ingredients, category) {
        try {
            const foods = await FoodModel.find({ ingredients: { $in: ingredients }, category: category });
            return foods;
        } catch (error) {
            throw error;
        }
    }
    // Find Food by only ingredients
    static async findFoodsByOnlyIngredients(ingredients) {
        try {
            const foods = await FoodModel.find({ ingredients: { $in: ingredients } });
            return foods;
        } catch (error) {
            throw error;
        }
    }
    // Get adder by food properties
    static async getAdderByFood(name, ingredients, preparing) {
        try {
            const food = await FoodModel.findOne({ name, ingredients, preparing });
            return food;
        } catch (error) {
            throw error;
        }
    }
}

module.exports = FoodService;

/*
const FoodModel = require('../model/food_model');

class FoodService {
    //YEMEK EKLEME
    static async addFood(adder, name, ingredients, Idpreparing) {
        try {
            const food = new FoodModel({ adder: adder, name: name, ingredients: ingredients, preparing: preparing });
            await food.save();
            return food;
        } catch (error) {
            
        }
    }
    //EKLENEN YEMEKLERİ GETİRME
    static async getAddedFoods(adder) {
        try {
            const foods = await FoodModel.find({ adder:adder });
            return foods;
        } catch (error) {
            throw error;
        }
    }
    //İÇİNDEKİ MALZEMELERE GÖRE YEMEKLERİ GETİRME
    static async findFoodsByIngredients(ingredients) {
        try {
            const foods = await FoodModel.find({ ingredients: { $in: ingredients } });
            return foods;
        } catch (error) {
            throw error;
        }
    }
    //YEMEĞE GÖRE EKLEYENİN ID'SİNİ GETİRME
        static async getAdderByFood(name, ingredients, preparing) {
        try {
            const food = await FoodModel.findOne({name:name, ingredients:ingredients, preparing:preparing});
            return food;
        } catch (error) {
            throw error;
        }
    }
}
*/

//BİRKAÇ ADET FONKSİYONUMUZ VAR
//1-ADDEDFOOD, YEMEK EKLEME,
//2-SAVEFOOD, YEMEK KAYDETME, 
//3-GETADDEDFOOD, EKLENEN YEMEKLERİ EKLEYENE GÖRE GETİRME, 
//4-GETSAVEDFOOD KAYDEDİLEN YEMEKLERİ EKLEYENE GÖRE GETİR
//5-FINDFOODSBYINGREDIENTS, MALZEMELERE GÖRE YEMEKLERİ BULMA
//6-EKLEYENİNE GÖRE YEMEĞİ BULMA
module.exports = FoodService;

/*
const FoodModel = require('../model/food_model');

class FoodService {
    static async saveFood(userId,name, ingredients, preparing) {
        try {
            const createFood = new FoodModel({ userId:userId, name:name,ingredients:ingredients,preparing: preparing});
            return await createFood.save()
        } catch (error) {
            throw error;
        }
    }

    static async findFoodsByIngredients(ingredients) {
        try {
            const foods = await FoodModel.find({ ingredients: { $in: ingredients } });
            return foods;
        } catch (error) {
            throw error;
        }
    } 
    static async getaddedFoods(userId) {
        try {
            const foods = await FoodModel.find(userId);
            return foods;
        } catch (error) {
            throw error;
        }
    }
    static async getFood_id(foodid){
        try {
           const foods = await FoodModel.findOne({_id: foodid});
           return foods;
        } catch (error) {
            
        }
    }
}

module.exports = FoodService;
*/
