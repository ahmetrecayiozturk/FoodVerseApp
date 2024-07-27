const router = require('express').Router();
const FoodController = require('./FoodService/controller/food_controller');
const UserController = require('./AuthService/controller/user_controller');
const savedFoodController = require('./FoodService/controller/food_save_controller');
router.post('/foods', (req, res, next) => {
    FoodController.addFood(req, res, next);
});
router.post('/find-foods', (req, res, next) => {
    FoodController.findFoodsByIngredients(req, res, next);
});
router.post('/registration', (req, res, next) => {
    UserController.register(req, res, next);
});
router.post('/login', (req, res, next) => {
    UserController.login(req, res, next);
});
router.post('/saved-foods',(req,res,nest)=>{
    savedFoodController.saveFood(req, res, nest);
})
router.post('/isuser-exist',(req, res, next) => {
    UserController.isUserExist(req, res, next);
})
router.post('/get-savedfoods',(req,res,next)=>{
    savedFoodController.getSavedFood(req,res,next);
})
router.post('/get-addedfoods',(req,res,next)=>{
    FoodController.getAddedFoods(req,res,next);
})
router.post('/get-adderbyfood',(req,res,next)=>{
    FoodController.getAdderByFood(req,res,next);
})
router.post('/find-food-only-by-ingredient',(req,res,next)=>{
    FoodController.findFoodsByOnlyIngredients(req,res,next);
})

router.post('/update-email',(req,res,next)=>{
    UserController.UpdateEmail(req,res,next);
})

module.exports = router;