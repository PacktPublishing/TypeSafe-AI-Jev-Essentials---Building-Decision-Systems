import express from 'express'
import multer from 'multer'
import cors from 'cors'
import fs from 'fs'
import { extractText } from 'unpdf'
import { readFile } from 'node:fs/promises'
import 'dotenv/config'
import { TypeSafeClient } from '@typesafe-ai/sdk'
import { resumeQuestions } from './questions/resumeQuestions.js'
import { mapResumeEvaluation } from './mappers/resumeEvaluationMapper.js'

const app = express()
app.use(cors())

const client = new TypeSafeClient()

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

    const response = await client.systemOne({
        state: { document: text },
        questions: resumeQuestions
    })

    const evaluation = mapResumeEvaluation(response)
    res.json(evaluation)
})

app.listen(8080, () => {
    console.log('Server is running...')
}) 