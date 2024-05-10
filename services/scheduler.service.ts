import type { Env } from "~/types"


export default {

    async getAllJobs(env: Env | undefined) {
        try {
            const uri = '/api/job/suiviExploit'
            const { url: urlHost, auth: auth } = getDetailEnv(env)
            const url = `${urlHost}/${uri}`
            return request(url, 'GET', auth)
        } catch (e) {
            throw e
        }


    }

}

async function request(url: string, method: 'GET' | 'POST', auth: string) {
    let data = []
    try {
        const response = await fetch(`${url}`, {
            method: method,
            headers: { Authorization: `Basic ${auth}` }
        })
        data = await response.json()
    } catch (e) {
        const err = e !== undefined ? String(e) : `Erreur inconnue lors de la execution du la requete HTTP [${method}] sur l'URL [${url}]`
        throw new Error(err)
    }
    return data || []
}

function getDetailEnv(env: Env | undefined) {
    const runtimeConfig = useRuntimeConfig()
    let data: any = []
    let url: string = ''
    let auth: string = ''
    if ((typeof env !== 'undefined') && (env in runtimeConfig.vtom.data)) {
        data = runtimeConfig.vtom.data[env]
        auth = btoa(`${data.user}:${data.passwd}`)
        url = `${runtimeConfig.vtom.url.sheme}://${runtimeConfig.vtom.url.ip}:${runtimeConfig.vtom.url.port}`
    }
    return { url: url, auth: auth }

}