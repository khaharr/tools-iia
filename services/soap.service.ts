import soap from 'soap'
import { parse } from 'vue/compiler-sfc'


export type paramSoap = {
    exer: string
    mel: string
    montant: string
    numcli: string
    objet: string
    refdet: string
    saisie: string
    urlnotif: string
    urlredirect: string
    typeAuthentification?: string
    typeUsager?: string
}
type responsePaiement = {
    data: {
        [key: string]: any
    },
    status: ('ok' | 'ko')
}
type errorPaiement = {
    [key: string]:
    {
        "code": string,
        "descriptif": string,
        "libelle": string,
        "severite": string
    }
}
export async function createPaiement(param: paramSoap): Promise<responsePaiement> {
    const urlPayfip = 'http://10.156.13.98/tpi-zu/paiementws.web?idop='
    const url = 'public/PaiementSecuriseService.wsdl'

    const args = {
        exer: param.exer,
        mel: param.mel,
        montant: param.montant,
        numcli: param.numcli,
        objet: param.objet,
        refdet: param.refdet,
        saisie: param.saisie,
        urlnotif: param.urlnotif,
        urlredirect: param.urlredirect,
        typeAuthentification: param.typeAuthentification || '',
        typeUsager: param.typeUsager || ''
    }
    // On desactive le proxy pour lancer la requete soap 
    process.env.npm_config_proxy = ''

    const client = await soap.createClientAsync(url)

    try {
        const result: any[] = await client.creerPaiementSecuriseAsync({ arg0: args })
        const idop = result[0]['return'].idOp
        return { data: { url: `${urlPayfip}${idop}` }, status: 'ok' }
    } catch (e) {
        // le format de l'erreur n'est ni une chaine de caractere ni un json .
        // Solution: 
        //     1 - transformer en chaine de caractere puis en tableau
        //     2 - On enleve les 4 champs pour former un json

        const err = JSON.parse(String(e).split(':').slice(4).join(':'))
        return { data: { error: err }, status: 'ko' }
    }

}