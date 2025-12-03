
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import fetch from 'node-fetch';
import mysql from 'mysql2/promise';
import bodyParser from 'body-parser';

dotenv.config();
const app = express();
app.use(cors());
app.use(bodyParser.json());

const db = await mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: 'mokify'
});

app.post('/api/gemini', async (req,res)=>{
  try{
    const r = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key=${process.env.GEMINI_KEY}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      // forward the exact body the frontend sends (prompt, config, etc.)
      body: JSON.stringify(req.body)
    });
    const data = await r.json();
    res.json(data);
  }catch(e){
    console.error("Gemini proxy error", e);
    res.status(500).json({error:e.toString()});
  }
});

app.listen(3000,()=>console.log("OK"));
