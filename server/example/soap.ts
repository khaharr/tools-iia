import { createPaiement, type paramSoap } from "~/services/soap.service"

export default defineEventHandler(async (event) => {

    const dataQuery: paramSoap = getQuery(event)
    const args = {
        exer: dataQuery.exer || '',
        mel: dataQuery.mel || '',
        montant: dataQuery.montant || '',
        numcli: dataQuery.numcli || '',
        objet: dataQuery.objet || '',
        refdet: dataQuery.refdet || '',
        saisie: dataQuery.saisie || '',
        urlnotif: dataQuery.urlnotif || '',
        urlredirect: dataQuery.urlredirect || ''
    }
    const result = await createPaiement(args)

    return result

})
