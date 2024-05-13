<script setup>
const typePaiement = ref('soap')
const title = ref()
onChangeInfo()

function onChangeInfo() {
  if (typePaiement.value == 'soap') {
    title.value = "Creation d'un paiement par web service"
  } else if (typePaiement.value == 'url') {
    title.value = "Creation d'un paiement par URL"
  } else {
    title.value = "Redirection pour paiement par portail"
  }

}
async function paiement() {
  // cas portail une simple redirection vers tipi ZU IIA
  if (typePaiement.value == 'portail') {
    window.open('http://10.156.13.98/tpi-zu/accueilportail.web', '_blank')
    return
  }

  const formData = new FormData(document.getElementById('info'))


  if (typePaiement.value == 'soap') {
    const data = {}
    formData.forEach((value, key) => {
      data[key] = value
    })
    const { data: result } = await useFetch('/api/example/soap',
      {
        query: data
      })
    console.log(result.value.data)
    if (result.value.status === 'ok') {
      window.open(result.value.data.url, '_blank')
    } else {
      console.log('erreur')
    }
  } else {
    const query = new URLSearchParams()
    formData.forEach((value, key) => {
      query.set(key, value)
    })
    window.open(`http://10.156.13.98/tpi-zu/paiement.web?${query.toString()}`, '_blank')
    console.log('ok')
    // 'http://10.156.13.98/tpi-zu/paiementws.web?'
  }



}

</script>
<template>
  <div class="container">
    <div class="payment-form-container mt-5">
    <h1>{{ title }}</h1>
        <div class="d-flex justify-content-center">
          <div class="d-flex justify-content-center">
          <div class="form-check m-3">
                <input @change='onChangeInfo' class="form-check-input" type="radio" name="radio" value="soap"
                  v-model="typePaiement" id="radio1" checked>
                  <label class="form-check-label" for="radio1">
                    Web service
                  </label>
                </div>
                <div class="form-check m-3">
                  <input @change='onChangeInfo' class="form-check-input" type="radio" name="radio" value="url"
                    v-model="typePaiement" id="radio2">
                  <label class="form-check-label" for="radio2">
                    URL
                  </label>
                </div>
                <div class="form-check m-3">
                  <input @change='onChangeInfo' class="form-check-input" type="radio" name="radio" value="portail"
                    v-model="typePaiement" id="radio3">
                  <label class="form-check-label" for="radio3">
                    Portail
                  </label>
          </div>
      </div>
    </div>
    <form id="info" class="w-50 m-auto" v-if="typePaiement != 'portail'">
      <input required class="form-control" type="text" name='exer' placeholder="Exercice"><br>
      <input required class="form-control" type="mail" name='mel' placeholder="Mail"><br>
      <input required class="form-control" type="text" name='montant' placeholder="Montant"><br>
      <input required class="form-control" type="text" name='numcli' placeholder="Numéro de client"><br>
      <input required class="form-control" type="text" name='objet' placeholder="Objet"><br>
      <input required class="form-control" type="text" name='refdet' placeholder="Reférence de la dette"><br>
      <input required class="form-control" type="text" name='saisie' placeholder="Saisie"><br>
      <input required class="form-control" type="text" name='urlnotif' placeholder="Url de notification"><br>
      <input required class="form-control" type="text" name='urlredirect' placeholder="Url de redirection"><br>

      <input class="btn btn-danger " type="reset" value='Annuler'>
    </form>
    <div class="d-flex justify-content-center">

    <input type="submit"  class="btn btn-primary  " @click="paiement" value='Création du paiement'>
    </div>
  </div>
</div>
</template>

<style>
.payment-form-container {
  background-color: rgb(255, 255, 255);
  border: 1px solid #000000;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  border-radius: 10px;
  width: 70vw;
  box-shadow: 10px 5px 5px rgb(180, 180, 180);}
  
body{
  background-color: rgb(233, 233, 233);
}

.form-container {
  margin-bottom: 1rem;
}

.form-container input {
  margin-bottom: 0.5rem;
}
</style>
