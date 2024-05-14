import { defineEventHandler } from 'h3';
import { fileUpload } from '~/services/depot.service';
import { Client } from 'pg';

const client = new Client({
  host: 'localhost',
  port: 5432,
  database: 'tools-iia',
  user: 'postgres',
  password: 'postgres',
});

export default defineEventHandler(async (event) => {
  await client.connect();

  const files = await fileUpload(event);

  try {
    // Save the file names to the database
    const filesToInsert = files.map((file: { originalname: any; category: any; }) => ({
      name: file.originalname,
      category: file.category,
    }));

    const query = 'INSERT INTO files (name, category) VALUES ($1, $2)';
    for (const file of filesToInsert) {
      await client.query(query, [file.name, file.category]);
    }

    return { message: 'Files uploaded successfully.' };
  } catch (error) {
    console.error(error);
    return { message: 'An error occurred while uploading files.' };
  }
});