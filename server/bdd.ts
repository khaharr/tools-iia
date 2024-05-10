import ClientBdd from "~/services/clientBdd.service"

export default defineEventHandler(async () => {
    try {
        const clientBdd = new ClientBdd({ host: 'localhost', port: 5432, database: 'test', user: 'postgres', password: 'postgres' })
        await clientBdd.connect()
        const data = await clientBdd.query('SELECT * from maTable')
        clientBdd.close()
        return "data"
    } catch (e) {

        console.log()
        return e
    }

})


