const express = require('express')
const axios = require('axios')
const app = express()
const port = 3000

/**
 * This application is to be friendly to other apis
 */

const ghettoCache = {}

const getMissingImage = async (size, position) => {
  const endpoint = `https://picsum.photos/id/${position}/${size}/${size}`

  const response = await axios.get(endpoint, { responseType: 'arraybuffer' })
  const buffer = Buffer.from(response.data, 'binary')
  ghettoCache[size] = {
    files: {
      [position]: buffer.toString('base64'),
    }
  }
}

const getImage = async (size, position) => {
  const existingImage = ((ghettoCache[size] || {}).files || {})[position]
  if (!existingImage) await getMissingImage(size, position)

  return ghettoCache[size].files[position]
}

app.get('/id/:id/:size', async (req, res) => {
  const { id, size } = req.params
  const position = (id % 5) + 50 // The + is a magic number (make sure its bigger than 0)

  const image = await getImage(size, position)
  res.contentType('image/jpeg')
  res.setHeader('Content-Disposition', `filename="file${Math.floor(Math.random() * 100000)}.jpg"`)
  res.setHeader('Etag', `${Math.random()}${Math.random()}`)

  res.send(new Buffer(image, 'base64'))
})

app.listen(port, () => console.log(`App listening on port ${port}!`))