import pg from 'pg';
import file from '~/server/example/file';
import { clientBdd } from '~/services/bdd.service';

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

  const rows = await readBody(event);
  const data =await clientBdd.sendDataToDatabase(client, rows);
  const data1 = await clientBdd.file(client,uploadedFiles)
  await client.end();
  return data;
});