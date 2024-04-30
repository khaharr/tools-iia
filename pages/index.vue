<template>
  <form class="was-validated">

  <div class="bgg">
    <div>
      <div class="p-5">
        <div class="container">
          <div class="box ">
            <!-- Champ de recherche par nom de fichier -->
            <div class="input-container">
              <input  type="search" class="form-control" v-model="searchTerm"  placeholder="Nom du fichier" required >
              <div class="invalid-feedback fixer">mettre un nom de fichier</div>
              
              <div class="loader" v-show="searching"></div> <!-- Loader pour simuler le chargement -->
            </div>
            
             <!-- Champ de sélection de catégorie -->
             <div class="input-container">
              <select class="form-select " v-model="selectedCategory "  required >
                <option value="">Toutes les catégories</option>
                <option v-for="category in uniqueCategories" :value="category">{{ category }}</option>
              </select>
              <div class="invalid-feedback fixer">mettre une catégorie</div>
              <div class="loader" v-show="searching"></div> <!-- Loader pour simuler le chargement -->
            </div>

            <!-- Champ de sélection de date -->
            <div class="input-container">
              <input type="date" class="form-control" v-model="selectedDate">
              <div class="loader" v-show="searching"></div> <!-- Loader pour simuler le chargement -->
            </div>
          </div>
        </div>
      </div>
    </div>
      <!-- Tableau des données filtrées -->
      <table class="table ta table-hover">
        <thead class="table-dark">
          <tr>
            <th scope="col">id</th>
            <th scope="col">nom fichier</th>
            <th scope="col">category</th>
            <th scope="col">date mise en ligne</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <tbody>
  <tr v-if="filteredItems.length > 0" v-for="(item, index) in filteredItems" :key="index">
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
  <tr v-else>
    <td colspan="5" class="error">Aucun résultat trouvé </td>
  </tr>
</tbody>
      </table>
    </div class="generate">
      <BoutonGenerer/>
    <div >

    </div>
</form>
</template>

<script setup>

const items = [
  { nomfichier: 'Mark', category: 'Otto', date: '2024-04-29' },
  { nomfichier: 'Jacob', category: 'Thornton', date: '2023-09-10' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'Larry', category: 'the Bird', date: '2005-08-12' },
  { nomfichier: 'khalid', category:'developpeur',date:'30-04/2024'},

];

// Variables de données 
const searchTerm = ref('');
const selectedCategory = ref('');
const selectedDate = ref('');
const searching = ref(false);

// Fonction de filtrage des éléments
const filteredItems = computed(() => {
  let filtered = items;
  //condition pour la barre de rechercche fait dynmiquement avec la fonctionalité filter qui permet de renvoyer un tableau d'elt qui s'actualise dynamiquement

  if (searchTerm.value.trim() !== '') {
    filtered = filtered.filter(item => item.nomfichier.toLocaleLowerCase().includes(searchTerm.value.toLocaleLowerCase()));
  }

  if (selectedDate.value !== '') {
    filtered = filtered.filter(item => item.date === selectedDate.value);
  }

  if (selectedCategory.value !== '') {
    filtered = filtered.filter(item => item.category === selectedCategory.value);
  }
  
  // if( filtered == false){
  //   setTimeout(() => {
  //     alert(' cest vide ...')
  //  }, 1000); 
  // };

  return filtered;
});

// Récupération des catégories uniques ()
const uniqueCategories = computed(() => 
[...new Set(items.map(item => item.category))]);

//  Fonction de recherche (simulée ici)
// function filterItems() {
//   searching.value = true;
//   setTimeout(() => {
//     searching.value = false;
//   }, 1000); 
// }
</script>




<style lang="scss" scoped>
.fixer{
  position: fixed;
}

.container {
  }
  
  .box {
	display: flex;
	align-items: center;
  }
  
  .input-container {
	position: relative;
	margin-right: 20px;
  }
  
  .error{
    color: #d30000;
  }
  .form-control {
  }
  
  // .loader {
	// position: absolute;
	// top: 50%;
	// right: 10px;
	// transform: translateY(-50%);
	// border: 2px solid #0000FF;
	// border-top: 2px solid transparent;
	// border-radius: 50%;
	// width: 12px;
	// height: 12px;
	// animation: spin 1s linear infinite;
	// display: none;
  // }
  
  // @keyframes spin {
	// 0% { transform: rotate(0deg); }
	// 100% { transform: rotate(360deg); }
  // }
  
  // /* Afficher le loader lorsque l'input est en focus */
  // .input-container .form-control:focus + .loader {
	// display: block;
  // }
.bgg {
  background-color: #DDD0C8;
}

.generate{
  margin-left: auto;
    margin-right: auto;
}

.table {
  width: 100vw;
  border-collapse: collapse;

}

th, td {
  border: 1px solid #323232;
  padding: 8px;
  text-align: left;
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
  border: solid #01792f;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
  display: none;
}

.checkbox:checked + .custom-checkbox::after {
  display: block;
}
</style>
