<template>
  <div class="bgg">
    <div>
      <div class="p-5">
        <div class="container">
          <div class="box d-flex">
            <!-- Champ de recherche par nom de fichier -->
            <div class="input-container">
              <input type="search" class="form-control" v-model="searchTerm" placeholder="Nom du fichier">
              <div class="loader" v-show="searching"></div> <!-- Loader pour simuler le chargement -->
            </div>
            <!-- Champ de sélection de date -->
            <div class="input-container">
              <input type="date" class="form-control" v-model="selectedDate">
              <div class="loader" v-show="searching"></div> <!-- Loader pour simuler le chargement -->
            </div>
            <!-- Champ de sélection de catégorie -->
            <div class="input-container">
              <select class="form-select" v-model="selectedCategory">
                <option value="">Toutes les catégories</option>
                <option v-for="category in uniqueCategories" :value="category">{{ category }}</option>
              </select>
              <div class="loader" v-show="searching"></div> <!-- Loader pour simuler le chargement -->
            </div>
            <!-- Bouton de recherche -->
            <div class="input-container">
              <input type="submit" class="form-control" @click="filterItems" value="Rechercher">
            </div>
          </div>
        </div>
      </div>
    </div>
    <div>
      <!-- Tableau des données filtrées -->
      <table class="table">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">nom fichier</th>
            <th scope="col">category</th>
            <th scope="col">date mise en ligne</th>
            <th scope="col">Action</th> <!-- Colonne pour les checkboxes -->
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in filteredItems" :key="index">
            <th>{{ index + 1 }}</th>
            <td>{{ item.nomfichier }}</td>
            <td>{{ item.category }}</td>
            <td>{{ item.date }}</td>
            <!-- Colonne pour les checkboxes -->
            <td>
              <input type="checkbox" class="checkbox" :id="'checkbox-' + index">
              <label :for="'checkbox-' + index" class="custom-checkbox"></label>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const items = [
  { nomfichier: 'Mark', category: 'Otto', date: '2024-04-29' },
  { nomfichier: 'Jacob', category: 'Thornton', date: '2023-09-10' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },

];

// Variables de données réactives
const searchTerm = ref('');
const selectedCategory = ref('');
const selectedDate = ref('');
const searching = ref(false);

// Fonction de filtrage des éléments
const filteredItems = computed(() => {
  let filtered = items;

  if (searchTerm.value.trim() !== '') {
    filtered = filtered.filter(item => item.nomfichier.toLowerCase().includes(searchTerm.value.toLowerCase()));
  }
  if (selectedCategory.value !== '') {
    filtered = filtered.filter(item => item.category === selectedCategory.value);
  }
  if (selectedDate.value !== '') {
    filtered = filtered.filter(item => item.date === selectedDate.value);
  }

  return filtered;
});

// Récupération des catégories uniques
const uniqueCategories = computed(() => 
[...new Set(items.map(item => item.category))]);

// Fonction de recherche (simulée ici)
function filterItems() {
  searching.value = true;
  setTimeout(() => {
    searching.value = false;
  }, 1000); 
}
</script>




<style lang="scss" scoped>
.container {
	// Votre style container
  }
  
  .box {
	// Votre style box
	display: flex;
	align-items: center;
  }
  
  .input-container {
	position: relative;
	margin-right: 20px;
  }
  
  .form-control {
	// Votre style form-control
  }
  
  .loader {
	position: absolute;
	top: 50%;
	right: 10px;
	transform: translateY(-50%);
	border: 2px solid #0000FF;
	border-top: 2px solid transparent;
	border-radius: 50%;
	width: 12px;
	height: 12px;
	animation: spin 1s linear infinite;
	display: none;
  }
  
  @keyframes spin {
	0% { transform: rotate(0deg); }
	100% { transform: rotate(360deg); }
  }
  
  /* Afficher le loader lorsque l'input est en focus */
  .input-container .form-control:focus + .loader {
	display: block;
  }
.bgg {
  background-color: #ffafd0;
}

.table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

.checkbox {
  display: none;
}

.custom-checkbox {
  display: inline-block;
  width: 20px;
  height: 20px;
  background-color: transparent;
  border: 2px solid #ff61f7;
  border-radius: 3px;
  position: relative;
  transition: background-color 0.3s ease-in-out;
}

.custom-checkbox::after {
  content: "";
  position: absolute;
  top: 3px;
  left: 7px;
  width: 5px;
  height: 10px;
  border: solid #00ff62;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
  display: none;
}

.checkbox:checked + .custom-checkbox::after {
  display: block;
}
</style>
