import type { Client } from "pg";

export const file = {
  async upload(bdd: Client, uploadedFiles: { name: string; category: string; data: File }[]) {
    try {
      await bdd.connect();
      for (const file of uploadedFiles) {
        const arrayBuffer = await file.data.arrayBuffer();
        const buffer = Buffer.from(arrayBuffer);
        const result = await bdd.query('INSERT INTO files (name, category, data) VALUES ($1, $2, $3)', [file.name, file.category, buffer]);
        console.log('File uploaded successfully:', result.rowCount);
      }
      uploadedFiles = [];
    } catch (error) {
      console.error('Error uploading files:', error);
    } 
  }
};