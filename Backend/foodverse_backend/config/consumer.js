// consumer.js

const amqp = require('amqplib');

const RABBITMQ_URL = process.env.RABBITMQ_URL || 'amqp://rabbitmq:5672';
const QUEUE = 'user_registration'; // Kuyruk adı

async function consume() {
    try {
        const connection = await amqp.connect(RABBITMQ_URL);
        const channel = await connection.createChannel();
        await channel.assertQueue(QUEUE, { durable: true });

        console.log(`[*] Waiting for messages in ${QUEUE}. To exit press CTRL+C`);

        channel.consume(QUEUE, (msg) => {
            if (msg !== null) {
                const messageContent = JSON.parse(msg.content.toString());
                console.log("[x] Received message:", messageContent);
                // Burada gelen mesajı işleyebiliriz, örneğin kullanıcıyı kaydedebiliriz
                // handleUserRegistration(messageContent.email);

                channel.ack(msg);
            }
        });
    } catch (error) {
        console.error('Error consuming messages:', error);
    }
}

consume();
