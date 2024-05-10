// import { Client } from 'ssh2';
import Client from 'ssh2-sftp-client'

type paramSsh = {
    host: string,
    port: number,
    username: string,
    password: string
}
type resolvePromise = { data: string[], status: boolean }

/**
 * Classe utilitaire pour lister , recupérer ou déposer des fichier
 * Elle utilise les modules ssh2 et ssh2-sftp-client
 */
export class SFTPClient {
    client: Client | any
    constructor() {
        this.client = new Client()
    }

    /**
     * Initialisation une connexion ssh
     * @param {object} options Parametre pour initialiser la connection SSH
     */
    async connect(options: paramSsh) {
        try {
            await this.client.connect(options)
        } catch (e) {
            const err = e !== undefined ? String(e) : 'Erreur inconnue lors de la connection SSH'
            throw new Error(err)
        }
    }
    // fermeture de la connexion sftp
    async close() {
        await this.client.end()
    }

    // Lister un repertoire et retourne une liste objet fichier
    async listFiles(remoteDir: string, regex: { name?: string, type?: '-' | 'd' | 'l' }): Promise<Client.FileInfo[]> {
        console.log(`Listing ${remoteDir} ...`);
        let fileObjects: Client.FileInfo[] = []
        let functionRegex: Function | undefined
        try {
            if (regex) {
                functionRegex = (item: Client.FileInfo) => {
                    if (regex.type === undefined && regex.name !== undefined) {
                        let reg = new RegExp(regex.name);
                        return reg.test(item.name)
                    } else if (regex.type !== undefined && regex.name === undefined) {
                        let reg = new RegExp(regex.type);
                        return reg.test(item.type)
                    } else if (regex.type !== undefined && regex.name !== undefined) {
                        let regName = new RegExp(regex.name);
                        let regType = new RegExp(regex.type);
                        return regName.test(item.name) && regType.test(item.type)
                    }
                }
            }
            fileObjects = await this.client.list(remoteDir, functionRegex)

        } catch (e) {
            const err = e !== undefined ? String(e) : 'Erreur inconnue lors de la récupération des fichier'
            throw new Error(err)
        }

        return fileObjects;
    }


    // Déposer un fichier
    async uploadFile(localFile: string, remoteFile: string) {
        try {
            await this.client.put(localFile, remoteFile)
        } catch (e) {
            const err = e !== undefined ? String(e) : 'Erreur inconnue lors du upload du fichier'
            throw new Error(err)
        }
    }


    // Télécharger un fichier 
    async downloadFile(remoteFile: string, localFile: string) {
        try {
            await this.client.get(remoteFile, localFile)
        } catch (e) {
            const err = e !== undefined ? String(e) : `Erreur inconnue lors du téléchargement du fichier ${remoteFile}`
            throw new Error(err)
        }
    }


    // Supression fichier
    async deleteFile(remoteFile: string) {
        try {
            await this.client.delete(remoteFile)
            return { status: true }
        } catch (e) {
            const err = e !== undefined ? String(e) : `Erreur inconnue lors de la suppression du fichier ${remoteFile}`
            throw new Error(err)
        }

    }

}


