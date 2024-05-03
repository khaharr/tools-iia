
 export default  useBdd = {
  async function fetchAllData(bdd) {
    try {
       const result = await bdd.query('SELECT * FROM nom_fichier')
       data.value = result.rows.map((row: any) => ({
         id: row.id,
         nomfichier: row.nomfichier,
         category: row.category,
         date: row.date,
       }))
       return data.value
     } 
     catch (error) {
       console.error(error)
       return []
     }
   },

   async function fetchData(query: string) {
     try {
       const result = await bdd.query(query)
       return result.rows
     }
      catch (error) {
       console.error(error)
       return []
     }
   },

   return {
     fetchAllData,
     fetchData,
   }
 }
