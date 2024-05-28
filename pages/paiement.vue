<template>
  <div class="bgg">
    <div class="bubbles">
      <div class="bubble" v-for="n in 20" :key="n"></div>
    </div>
    <div class="container footer-space">
      <div class="payment-form-container p-4 rounded shadow">
        <h1 class="text-center mb-4">{{ title }}</h1>
        <div class="d-flex justify-content-center mb-4">
          <div class="form-check mx-2">
            <input @change="onChangeInfo" class="form-check-input" type="radio" name="radio" value="soap" v-model="typePaiement" id="radio1" checked>
            <label class="form-check-label" for="radio1">Web service</label>
          </div>
          <div class="form-check mx-2">
            <input @change="onChangeInfo" class="form-check-input" type="radio" name="radio" value="url" v-model="typePaiement" id="radio2">
            <label class="form-check-label" for="radio2">URL</label>
          </div>
          <div class="form-check mx-2">
            <input @change="onChangeInfo" class="form-check-input" type="radio" name="radio" value="portail" v-model="typePaiement" id="radio3">
            <label class="form-check-label" for="radio3">Portail</label>
          </div>
        </div>
        <form id="info" class="row g-3" v-if="typePaiement !== 'portail'">
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="exer" placeholder="Exercice *" maxlength="4" size="4">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="email" name="mel" placeholder="Mail *" minlength="6" maxlength="80" size="20">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="montant" placeholder="Montant *" maxlength="7" size="7">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="numcli" placeholder="Numéro de client *" maxlength="6" size="6">
          </div>
          <div class="col-md-6">
            <input class="form-control form-control-custom" type="text" name="objet" placeholder="Objet" maxlength="100" size="20">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="refdet" placeholder="Référence de la dette *" minlength="6" maxlength="30" size="15">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="saisie" placeholder="Saisie *" maxlength="1" size="1">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="urlnotif" placeholder="Url de notification *" maxlength="250" size="30">
          </div>
          <div class="col-md-6">
            <input required class="form-control form-control-custom" type="text" name="urlredirect" placeholder="Url de redirection *" maxlength="250" size="30">
          </div>
          <div class="col-md-12 d-flex justify-content-end mt-3">
            <input class="btn btn-danger me-2" type="reset" value="Annuler">
          </div>
        </form>
        <div class="d-flex justify-content-center mt-3">
          <input type="submit" class="btn btn-primary" @click="paiement" value="Création du paiement">
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const typePaiement = ref('soap');
const title = ref();

function onChangeInfo() {
  if (typePaiement.value === 'soap') {
    title.value = "Création d'un paiement par web service";
  } else if (typePaiement.value === 'url') {
    title.value = "Création d'un paiement par URL";
  } else {
    title.value = "Redirection pour paiement par portail";
  }
}

onMounted(() => {
  onChangeInfo();
  const bubbles = document.querySelectorAll('.bubble');
  bubbles.forEach(bubble => {
    bubble.style.setProperty('--random-left', Math.random());
  });
});

async function paiement() {
  if (typePaiement.value === 'portail') {
    window.open('http://10.156.13.98/tpi-zu/accueilportail.web', '_blank');
    return;
  }

  const formData = new FormData(document.getElementById('info'));

  if (typePaiement.value === 'soap') {
    const data = {};
    formData.forEach((value, key) => {
      data[key] = value;
    });
    const { data: result } = await useFetch('/api/example/soap', { query: data });
    console.log(result.value.data);
    if (result.value.status === 'ok') {
      window.open(result.value.data.url, '_blank');
    } else {
      console.log('erreur');
    }
  } else {
    const query = new URLSearchParams();
    formData.forEach((value, key) => {
      query.set(key, value);
    });
    window.open(`http://10.156.13.98/tpi-zu/paiement.web?${query.toString()}`, '_blank');
    console.log('ok');
  }
}
</script>

<style scoped>
.bgg {
  background-color: #5b5b5b;
  position: relative;
  overflow: hidden;
  padding: 20px;
}

.bubbles {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.bubble {
  position: absolute;
  bottom: -150px;
  width: 30px;
  height: 30px;
  background-color: rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  animation: rise 10s infinite ease-in-out, shimmer 2s infinite;
  box-shadow: 0 0 10px rgb(255, 255, 255), 0 0 20px rgb(255, 255, 255), 0 0 30px rgb(255, 255, 255);
}

@keyframes rise {
  0% {
    transform: translateY(0) scale(1);
  }
  50% {
    transform: translateY(-400px) scale(1.2);
  }
  100% {
    transform: translateY(-900px) scale(1);
  }
}

@keyframes shimmer {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
  100% {
    opacity: 1;
  }
}

.bubble:nth-child(2n) {
  animation-duration: 12s;
  animation-delay: 2s;
}

.bubble:nth-child(3n) {
  animation-duration: 14s;
  animation-delay: 4s;
}

.bubble:nth-child(4n) {
  animation-duration: 16s;
  animation-delay: 6s;
}

.bubble:nth-child(5n) {
  animation-duration: 18s;
  animation-delay: 8s;
}

.bubble:nth-child(6n) {
  animation-duration: 20s;
  animation-delay: 10s;
}

.bubble {
  left: calc(100% * var(--random-left));
}

.payment-form-container {
  background-color: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s, box-shadow 0.2s;
  position: relative;
  z-index: 2;
}

.payment-form-container:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
}

.footer-space {
  margin-bottom: 50px;
}

h1 {
  font-size: 1.8rem;
  color: #333333;
  font-weight: bold;
}

.form-check-label {
  margin-left: 5px;
  color: #555555;
}

.form-control-custom {
  border-radius: 5px;
  border: 1px solid #cccccc;
  padding: 0.75rem;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.form-control-custom:focus {
  border-color: #0056b3;
  box-shadow: 0 0 0 0.2rem rgba(0, 86, 179, 0.25);
  animation: inputFocus 0.5s ease-in-out;
}

.form-control-custom:valid {
  border-color: #28a745;
  box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
}

.form-control-custom:invalid {
  animation: shake 0.5s;
}

.form-control-custom:invalid:focus{
 border-color: #c9302c;
 box-shadow: 0 0 0 0.2rem rgba(255, 3, 3, 0.25);

}
@keyframes inputFocus {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}

@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  20%, 60% {
    transform: translateX(-10px);
  }
  40%, 80% {
    transform: translateX(10px);
  }
}

.btn-primary {
  background-color: #0056b3;
  border-color: #0056b3;
  transition: background-color 0.2s, transform 0.2s;
}

.btn-primary:hover {
  background-color: #004494;
  transform: translateY(-3px);
}

.btn-danger {
  background-color: #d9534f;
  border-color: #d9534f;
  transition: background-color 0.2s, transform 0.2s;
}

.btn-danger:hover {
  background-color: #c9302c;
  transform: translateY(-3px);
}
</style>
