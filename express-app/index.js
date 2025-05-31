const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.send('<h1>Hello World, I\'m deploying pipelines to Heroku!</h1>')
})

const PORT = 80

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})
