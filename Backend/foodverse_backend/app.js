// app.js

// express'i import edelim
const express = require('express');
// app'i oluşturalım
const app = express();
// body parser'i require edelim
const bodyParser = require('body-parser');
// app'in body parser'i kullanmasını sağlayalım
app.use(bodyParser.json());
// router'i import edelim
const Routers = require('./routers.js');

// app üzerinde router'i kullanalım
app.use('/', Routers);

// const foodRouter = require('./routers/food_router');
// app.use('/', foodRouter);

// app'i export edelim
module.exports = app;

/*
// express'i import edelim
const express = require('express');
// app'i oluşturalım
const app = express();
// body parser'i require edelim
const bodyParser = require('body-parser');
// app'in body parser'i kullanmasını sağlayalım
app.use(bodyParser.json());
// router'i import edelim
const Routers = require('./routers.js');

// app üzerinde router'i kullanalım
app.use('/', Routers);

// const foodRouter = require('./routers/food_router');
// app.use('/', foodRouter);

// app'i export edelim
module.exports = app;
*/