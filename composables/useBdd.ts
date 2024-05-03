
import type { Client } from "pg"

export  const useBdd = {
  async  fetchAllData(bdd: Client) {
    try {
      
       const result = await bdd.query('SELECT * FROM nom_fichier')
       const data = result.rows.map((row: any) => ({
         id: row.id,
         nomfichier: row.nomfichier,
         category: row.category,
         date: row.date,
       }))
       return data
     } 
     catch (error) {
       console.error(error)
       return []
     }
   },

   async  fetchData(bdd:Client,query: string) {
     try {
       const result = await bdd.query(query)
       return result.rows
     }
      catch (error) {
       console.error(error)
       return []
     }
   }

 }
