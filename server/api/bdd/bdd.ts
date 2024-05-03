import pg from 'pg'
export default defineEventHandler(async (event) => {
const {Client } = pg

const client = new Client({
  host: 'localhost',
  port: 5432,
  database: 'tools-iia',
  user: 'postgres',
  password: 'postgres',
})
})
