// const { MongoClient } = require('mongodb');

// const mongoURI = "mongodb+srv://Diya:diya%40mongo@sih.ovpozyi.mongodb.net/Urban_Seva?retryWrites=true&w=majority";

// let cachedClient = null;

// async function connectToDatabase() {
//   if (cachedClient) {
//     return cachedClient;
//   }

//   try {
//     const client = new MongoClient(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true });
//     await client.connect();
//     console.log('Connected to MongoDB');
//     cachedClient = client;
//     return client;
//   } catch (error) {
//     console.error('MongoDB connection error:', error);
//     throw new Error('Failed to connect to MongoDB');
//   }
// }

// module.exports = connectToDatabase;
