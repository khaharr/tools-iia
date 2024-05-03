import pg from 'pg'
import useBdd from '~/composables/useBdd';
const { Pool, Client } = pg

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'tools-iia',
  user: 'postgres',
  password: 'postgres',
})
export { pool as default };