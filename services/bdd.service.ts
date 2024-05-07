import type { Client } from "pg";

export const clientBdd = {
  async fetchAllData(bdd: Client) {
    try {
      const result = await bdd.query('SELECT * FROM nom_fichier');
      const data = result.rows.map((row: any) => ({
        nomfichier: row.nomfichier,
        category: row.category,
        date: row.date,
        id: row.id,
      }));
      return data;
    } catch (error) {
      console.error(error);
      return [];
    }
  },

  async sendDataToDatabase(bdd: Client, rows: any[]) {
    try {
      const query = `INSERT INTO recuperer_donne (nomfichier, category, date, id) VALUES ${rows
       .map((row) => `('${row.nomfichier}', '${row.category}', '${row.date}', ${row.id})`)
       .join(", ")};`;
      await bdd.query(query);
    } catch (error) {
      console.error(error);
    }
  },
};
