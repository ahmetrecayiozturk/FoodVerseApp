const SavedFoodService = require('../service/food_save_services.js');
const SavedFoodModel = require('../model/food_save_model.js');
exports.saveFood = async function(req,res,next){
    try {
        const {Id,name,ingredients,preparing} = req.body;
        const isexistsavedfood = await SavedFoodModel.findOne({name})
        if(!isexistsavedfood){
        const savedFood = await SavedFoodService.saveFood(Id,name,ingredients,preparing);
        res.status(201).json({
            message: "food saved",
            savedFood
        });}
        else{
            res.status(400).json({
                message: "food already exists"
            });
        }
    } catch (error) {
        next(error);
    }
} 


exports.getSavedFood = async function(req, res, next){
    try {
        const {Id} = req.body;
        const savedFood = await SavedFoodService.getSavedFood(Id);
        res.json(savedFood);
    } catch (error) {
        next(error);
    }
}
