import express from 'express'
import multer from 'multer'
import cors from 'cors'
import fs from 'fs'
import { extractText } from 'unpdf'
import { readFile } from 'node:fs/promises'
import 'dotenv/config'

const app = express()
app.use(cors())

const upload = multer({
    dest: 'uploads/'
})

app.post('/api/upload', upload.single('resume'), async (req, res) => {

    // extract the text from the resume 
    const buffer = await readFile(req.file.path)
    const { text } = await extractText(
        new Uint8Array(buffer),
        { mergePages: true }
    )

    console.log(text)
    // pass the resume text to Jev 
})

app.listen(8080, () => {
    console.log('Server is running...')
})