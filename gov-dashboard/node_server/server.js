const express = require('express');
const cors = require('cors');
const { MongoClient } = require('mongodb');

const startServer = async () => {
  const app = express();
  const PORT = 3000;

  // MongoDB connection string
  const uri = "mongodb+srv://Diya:diya%40mongo@sih.ovpozyi.mongodb.net/Urban_Seva?retryWrites=true&w=majority";
  const client = new MongoClient(uri, { useUnifiedTopology: true });

  try {
    // Connect to MongoDB using async/await
    await client.connect();
    console.log('Connected to MongoDB');

    // Middleware to pass the MongoDB client instance to the request object
    app.use((req, res, next) => {
      req.db = client.db('Urban_Seva');
      next();
    });

    app.use(cors());
    app.use(express.json());

    app.get('/api/checkUser', async (req, res) => {
      try {
        const { email } = req.query;

        const userCollection = req.db.collection('Govn');
        const userData = await userCollection.findOne({ email });

        // If userData is not empty, a user with this email exists
        res.json({ exists: userData !== null, userdata: userData });
      } catch (error) {
        console.error('Error checking user existence:', error);
        res.status(500).json({ error: 'Internal Server Error' });
      }
    });

    app.post('/api/addAlert', async (req, res) => {
      try {
        const { auth, desc, date, time } = req.body;

        const alertCollection = req.db.collection('Alerts');
        result = await alertCollection.insertOne({ auth, desc, date, time });
        console.log(result);
        
        if (result != null) {
          res.status(201).json({ success: 'Alert inserted successfully' });
        } else {
          res.status(409).json({ error: 'Failed to insert alert' });
        }
      } catch (error) {
        console.error('Error inserting alert:', error);
        res.status(500).json({ error: 'Internal Server Error' });
      }
    });

    // Start the server
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error('Error connecting to MongoDB:', error);
  }
  
  // Handling server shutdown
  process.on('SIGINT', () => {
    console.log('Closing MongoDB connection and shutting down server...');
    client.close().then(() => {
      console.log('MongoDB connection closed.');
      process.exit(0);
    });
  });

  process.on('SIGTERM', () => {
    console.log('Closing MongoDB connection and shutting down server...');
    client.close().then(() => {
      console.log('MongoDB connection closed.');
      process.exit(0);
    });
  });
};

// Invoke the asynchronous function to start the server
startServer();
