const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.send('<h1>Hello World, I\'m deploying pipelines to Heroku!</h1>')
})

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})
