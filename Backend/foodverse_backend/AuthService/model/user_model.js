const mongoose = require('mongoose');
const connection = require('../../config/db.js');
const bcrypt = require('bcrypt');
const { v4: uuidv4 } = require('uuid');

const { Schema } = mongoose;

const userSchema = new Schema({
    Id:{
        //random id
    type: String,
    default: uuidv4, // Generate a random UUID for the id
    unique: true // Ensure the id is unique
    },
    email: {
        type: String,
        required: true,
        lowercase: true,
        unique:true
    },
    password: {
        type: String,
        required: true
    }
});

userSchema.pre('save', async function(){
    // Şifreyi hashleyelim
    try {
        var user = this;
        const salt = await bcrypt.genSalt(10);
        const hashpass = await bcrypt.hash(user.password, salt);

        user.password = hashpass;

    } catch (error) {
        throw error;
    }
});

userSchema.methods.comparePassword = async function(userPassword) {
    try {
        const isMatch = await bcrypt.compare(userPassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
}


// UserModel'i oluşturalım
const UserModel = mongoose.model('MyUsersDataBase', userSchema);

// UserModel'i dışa aktaralım
module.exports = UserModel;
