import { defineEventHandler } from 'h3';
import { readBody, readRawBody } from 'h3';
import fs from 'fs';
import path from 'path';

export default defineEventHandler(async (event) => {
  const formData = await readMultipartFormData(event) 
  if (formData === undefined){
    return "error"
  };

  formData.forEach(file => {
    const fileBuffer: Buffer = file.data  
    const fileContent = fileBuffer.toString('utf8'); // converti
    console.log(file.filename , fileContent); 
  
  });

  return { message: 'Fichiers envoyés avec succès!' };
});