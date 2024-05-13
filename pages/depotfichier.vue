<template>
  <div class="bgg">
  <div class="container">
    <h1 >Déposer des fichiers</h1>
    <div class="row mt-4">
      <div class="col-md-6">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Sélectionner les fichiers à déposer</h5>
            <input type="file" class="form-control" id="inputGroupFile01" @change="handleFileUpload($event)">
            <div class="mt-3">
              <label for="categorySelect" class="form-label">Choisir la catégorie :</label>
              <select class="form-select" id="categorySelect" v-model="selectedCategory">
                <option value="">Sélectionner une catégorie</option>
                <option v-for="category in categories" :value="category" :key="category">{{ category }}</option>
              </select>
            </div>
            <button class="btn btn-primary mt-3" @click="uploadFiles">Déposer les fichiers</button>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card" v-if="depositedFiles.length > 0">
          <div class="card-body">
            <h5 class="card-title">Fichiers déposés</h5>
            <ul class="list-group">
              <li v-for="(file, index) in depositedFiles" :key="index" class="list-group-item d-flex justify-content-between align-items-center">
                <div>
                  <span>{{ file.name }}</span><br>
                  <span class="badge bg-secondary">{{ file.category }}</span>
                </div>
                <button class="btn btn-danger btn-sm" @click="removeFile(index)">Supprimer</button>
              </li>
            </ul>
            <button class="btn btn-success mt-3" @click="sendFilesToServer">Envoyer les fichiers</button>
            <div>
            <p class="mt-4">début du télechargement : </p>
            <div class="progress" role="progressbar"   aria-label="Animated striped example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
            <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 100%"></div>
          </div>
          </div>

          </div>
        </div>
        <div class="alert alert-info mt-3" role="alert" v-else>
          Aucun fichier déposé.
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

// Liste des catégories disponibles
const categories = ref<string[]>(['Catégorie 1', 'Catégorie 2', 'Catégorie 3']);
// Catégorie sélectionnée par l'utilisateur
const selectedCategory = ref<string>('');
// Liste des fichiers déposés
const depositedFiles = ref<{ name: string; category: string }[]>([]);
// Liste des fichiers téléversés
const uploadedFiles = ref<{ name: string; category: string }[]>([]);

// Fonction pour gérer le téléchargement des fichiers
const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement;
  const files = target.files;
  if (files) {
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
    }
  }
};

// Fonction pour déposer les fichiers dans la catégorie sélectionnée
const uploadFiles = () => {
  // Vérifier si une catégorie a été sélectionnée
  if (selectedCategory.value === '') {
    alert('Veuillez sélectionner une catégorie.');
    return;
  }

  // Récupérer les fichiers sélectionnés par l'utilisateur
  const input = document.querySelector('input[type="file"]') as HTMLInputElement;
  const files = input.files;
  console.log(files)

  // Vérifier si des fichiers ont été sélectionnés
  if (files) {
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      depositedFiles.value.push({ name: file.name, category: selectedCategory.value });
    }
  } else {
    alert('Veuillez sélectionner au moins un fichier.');
    return;
  }

  // Effacer les fichiers déposés de l'input file
  input.value = '';
};

// Fonction pour supprimer un fichier déposé
const removeFile = (index: number) => {
  depositedFiles.value.splice(index, 1);
};

// Fonction pour envoyer les fichiers au back
const sendFilesToServer = () => {
  const formData = new FormData();
  uploadedFiles.value.forEach(file => {
    formData.append('files[]', file.name);

  });

  fetch('/api/example/file', {
    method: 'POST',
    body: formData
  })
  .then(response => response.json())
  .then(data => {
    console.log('Fichiers envoyés avec succès:', data);
    // Réinitialiser la liste des fichiers téléversés
    uploadedFiles.value = [];
  })
  .catch(error => {
    console.error('Erreur lors de l\'envoi des fichiers:', error);
  });
};
</script>

<style scoped>
.bgg{
  background-color: #ddd0c8;

}
</style>
