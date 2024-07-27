const mongoose = require('mongoose');

const {Schema} = mongoose;

const FoodSaveSchema = new Schema({
    Id:{
        type: String,
        required: true
    },
    name:{
        type: String,
        required: true
    },
    ingredients: {
        type: [String],
        required: true
    },
    preparing: {
        type: String,
        required: true
    }
})

const FoodSaveModel = mongoose.model('SavedFood', FoodSaveSchema);

module.exports = FoodSaveModel;