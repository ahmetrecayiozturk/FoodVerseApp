const amqp = require('amqplib');

let channel = null;

const connectRabbitMQ = async () => {
    try {
        const connection = await amqp.connect(process.env.RABBITMQ_URL || 'amqp://localhost:5672');
        channel = await connection.createChannel();
        await channel.assertQueue('user_registration', { durable: true });
    } catch (error) {
        console.error('Error connecting to RabbitMQ:', error);
    }
};

const getChannel = () => channel;

module.exports = { connectRabbitMQ, getChannel };
