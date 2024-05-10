import pg from 'pg'
interface QuerySelector {
    table: string,
    id: number
}




export default class ClientBdd {
    private client: pg.Client

    constructor(params: string | pg.ClientConfig) {
        this.client = new pg.Client(params)
    }
    async connect(): Promise<void> {
        try {
            await this.client.connect()
        } catch (e) {
            const err = e !== undefined ? String(e) : 'Erreur inconnue lors de la connection à la BDD'
            throw new Error(err)
        }
    }
    async close(): Promise<void> {
        await this.client.end()
    }

    async query(query: string) {
        try {
            const result = await this.client.query(query)
            return result.rows
        }
        catch (e) {
            const err = e !== undefined ? String(e) : `Erreur inconnue lors de l'exécution de la requête [${query}]`
            throw new Error(err)
        }
    }

    async getById(params: QuerySelector) {
        try {

            const query = `SELECT * FROM ${params.table} WHERE id = ${params.id}`
            const result = await this.client.query(query)
            return result.rows[0] || []
        }
        catch (e) {
            const err = e !== undefined ? String(e) : `Erreur inconnue lors de récupération l'élément ayant pour ID [${params.id} ] sur le table [${params.table}]`
            throw new Error(err)
        }
    }
    async deleteById(params: QuerySelector) {
        try {
            const query = `DELETE FROM ${params.table} WHERE id = ${params.id}`
            await this.client.query(query)
        }
        catch (e) {
            const err = e !== undefined ? String(e) : `Erreur inconnue lors de la supression de l'élément ayant pour ID [${params.id} ] sur le table [${params.table}]`
            throw new Error(err)
        }
    }

}


