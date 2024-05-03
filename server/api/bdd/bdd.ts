import pg from 'pg'
import { useBdd } from '~/composables/useBdd'
export default defineEventHandler(async (event) => {
const {Client } = pg

const client = new Client({
  host: 'localhost',
  port: 5432,
  database: 'tools-iia',
  user: 'postgres',
  password: 'postgres',
})
  await client.connect() 

  return(useBdd.fetchAllData(client))
})

