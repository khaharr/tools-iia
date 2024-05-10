
import { SFTPClient } from "~/services/sftp.service"


export default defineEventHandler(async (event) => {
    const paramSsh = { host: '10.92.250.172', port: 22, username: 'root', password: 'master' }
    const sftp = new SFTPClient()
    let list
    try {
        await sftp.connect(paramSsh)
        list = await sftp.listFiles('/vtom/logs', { type: '-' })
    } finally {
        await sftp.close()
    }


    return list
})

