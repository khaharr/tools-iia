import pg from 'pg';
import { file } from '~/services/depot.service';

export default defineEventHandler(async (event) => {
  const { Client } = pg;
  const client = new Client({
    host: 'localhost',
    port: 5432,
    database: 'tools-iia',
    user: 'postgres',
    password: 'postgres',
  });

  await client.connect();

  const data = await file.upload(client, uploadedFiles)
  await client.end();
  return data ;
});