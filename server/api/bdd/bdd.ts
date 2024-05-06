import pg from 'pg'
import { clientBdd } from '~/services/bdd.service'
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
// console.log(useBdd.fetchAllData(client))
  return(clientBdd.fetchAllData(client))
})

