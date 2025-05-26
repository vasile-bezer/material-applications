const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.send('<h1>Hello World, I\'m deploying pipelines!</h1>')
})

const PORT = 8080

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})