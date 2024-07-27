// user_service.js

const UserModel = require('../model/user_model');
const jwt = require('jsonwebtoken');
const amqp = require('amqplib');

// RabbitMQ bağlantı URL'si
const RABBITMQ_URL = process.env.RABBITMQ_URL || 'amqp://rabbitmq:5672';
const QUEUE = 'user_registration'; // Kuyruk adı

class UserService {
    static async registerUser(email, password) {
        try {
            const isUserExist = await UserModel.findOne({ email });
            if (!isUserExist) {
                const createUser = new UserModel({ email, password });
                const newUser = await createUser.save();

                // RabbitMQ'ya mesaj gönderme işlemi
                await sendToQueue({ email }); // Kuyruğa mesaj gönder

                return newUser;
            } else {
                throw new Error("User Already Exist");
            }
        } catch (error) {
            throw error;
        }
    }

    static async checkUser(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (error) {
            throw error;
        }
    }

    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
    }

    static async UpdateEmail(email, newemail) {
        try {
            const user = await UserModel.findOneAndUpdate({ email }, { email: newemail }, { new: true });
            if (!user) {
                throw new Error("User Not Found");
            }
            return user;
        } catch (error) {
            throw error;
        }
    }
}
// RabbitMQ'ya mesaj gönderen fonksiyon
async function sendToQueue(message) {
    try {
        const connection = await amqp.connect(RABBITMQ_URL);
        const channel = await connection.createChannel();
        await channel.assertQueue(QUEUE, { durable: true });

        // Mesajı JSON formatında gönderiyoruz
        channel.sendToQueue(QUEUE, Buffer.from(JSON.stringify(message)));

        console.log(`[x] Sent message tooo ${QUEUE}: ${JSON.stringify(message)}`);

        setTimeout(() => {
            connection.close();
        }, 500);
    } catch (error) {
        console.error('Error sending message to queue:', error);
    }

}

module.exports = UserService;


/*
//we do crud operations

const UserModel = require('../model/user_model');
const jwt = require('jsonwebtoken');

//UserService class'ının oluşturulmaso
class UserService{
    //bir asenkron registerUser Fonksiyonu oluşturulur ve bu fonksiyon email ve password almaktadır
    static async registerUser(email, password) {
        try {
          const isUserExist = await UserModel.findOne({ email });
          if (!isUserExist) {
            const createUser = new UserModel({ email, password });
            const newUser = await createUser.save();
            return newUser;
          } else {
            throw new Error("User Already Exist");
          }
        } catch (error) {
          throw error;
        }
      }
    

    static async checkUser(email){
        try {
            return await UserModel.findOne({email});
        } catch (error) {
            throw error;
        }

    }

    static async generateToken(tokenData,secretKey,jwt_expire){
        return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});
    }
}


//sonra da bu UserService export edilir
module.exports = UserService;
*/



































/*
//GPT KISMI

const { exportUserModel } = require("../model/user_model");

const registerUser = async (req, res) => {
  try {
    const newUser = new exportUserModel(req.body);
    await newUser.save();
    res.status(201).json(newUser);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = { registerUser };
*/




/*
const UserModel = require('../model/user_model');

const registerUser = async (req, res) => {
    try {
        const User = await UserModel();
        const newUser = new User(req.body);
        await newUser.save();
        res.status(201).json(newUser);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = { registerUser };
*/



/*
const UserModel = require('../model/user_model');

class UserService {
    static async registerUser(email, password) {
        try {
            const createUser = new UserModel({ email, password });
            return await createUser.save();
        } catch (error) {
            throw error;
        }
    }
}
*/
//module.exports = UserService;
