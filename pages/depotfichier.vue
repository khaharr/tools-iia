<template>
    <div class="container mt-5">
      <h1>Déposer des fichiers</h1>
      <div class="card mt-3">
        <div class="card-body">
          <h5 class="card-title">Sélectionner les fichiers à déposer</h5>
          <input type="file" multiple @change="handleFileUpload" />
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
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue';
  
  // Liste des catégories disponibles
  const categories = ref(['Catégorie 1', 'Catégorie 2', 'Catégorie 3']);
  const selectedCategory = ref('');
  
  // Fonction pour gérer le téléchargement des fichiers
  const handleFileUpload = (event: any) => {
    // Récupérer les fichiers sélectionnés par l'utilisateur
    const files = event.target.files;
    console.log(files);
  };
  
  // Fonction pour déposer les fichiers dans la catégorie sélectionnée
  const uploadFiles = () => {
    // Vérifier si des fichiers ont été sélectionnés ,Vérifier si une catégorie a été sélectionnée
    if (selectedCategory.value === '') {
      alert('Veuillez sélectionner une catégorie.');
      return;
    }
    // Envoyer les fichiers à un serveur avec la catégorie sélectionnée
    // Code à implémenter pour envoyer les fichiers et la catégorie au serveur
  };
  </script>
  
  <style scoped>
  .container {
    max-width: 600px;
  }
  </style>
  