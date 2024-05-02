<template>
  <div class="bgg">
    <div class="p-5">
      <h3>filtre de recherche <i class="bi bi-search"></i></h3>
      <!-- <div class="container">
          <div class="box">
            Champ de recherche par nom de fichier 
            <div class="input-container">
              <input type="search" min="3" class="form-control" v-model="searchTerm" placeholder="Nom du fichier" />
               Message d'erreur en dessous du champ de recherche 
              <div class="error-message" v-if="searchTerm.length > 0 && searchTerm.length < 3">
                Veuillez saisir au moins 3 caractères.
              </div>
            </div>

            Champ de sélection de catégorie 
            <div class="input-container">
              <select class="form-select" v-model="selectedCategory" required>
                <option value="">Toutes les catégories</option>
                <option v-for="category in uniqueCategories" :value="category">{{ category }}</option>
              </select>
              <div class="invalid-feedback fixer">mettre une catégorie</div>
              <div class="loader" v-show="searching"></div>
              <Loader pour simuler le chargement -
            </div>

           Champ de sélection de date 
            <div class="input-container">
              <input type="date" class="form-control" v-model="startDate" />
            </div>
            <div class="input-container">
              <input type="date" class="form-control" v-model="endDate" />
            </div>
          </div>
        </div>-->
    </div>
    <!-- Tableau des données filtrées -->
    <div class="container-fluid">
      <table
        id="table"
        data-toggle="table"
        data-pagination="true"
        data-cookie="true"
        data-cookie-id-table="saveId"
        data-filter-control="true"
        data-search="true"
        data-click-to-select="true"
      >
        <thead class="table-dark">
          <tr>
            <th data-checkbox="true">id</th>
            <th data-field="nomfichier" data-searchable="true" data-click-to-select="true">nom fichier</th>
            <th data-field="category" data-filter-control="select" data-searchable="false">category</th>
            <th data-field="date" data-sortable="true" data-searchable="false">date mise en ligne</th>
          </tr>
        </thead>
        <!-- <tbody>
        <tr v-if="filteredItems.length > 0" v-for="(item, index) in filteredItems" :key="index">
          <th>{{ index + 1 }}</th>
          <td>{{ item.nomfichier }}</td>
          <td>{{ item.category }}</td>
          <td>{{ item.date }}</td>
          <td>
            <input type="checkbox" class="form-check-input" :id="'checkbox-' + index" />
          </td>
        </tr>
        <tr v-else>
          <td colspan="5" class="error">Aucun résultat trouvé</td>
        </tr>
      </tbody> -->
      </table>
    </div>
    <input type="submit" class="btn btn-primary" @click="refreshTable" value="rafraichissement" />
    <BoutonGenerer />
  </div>
</template>

<script setup>
const items = [
  { nomfichier: "Mark", category: "Otto", date: "2024-04-29" },
  { nomfichier: "Jacob", category: "Thornton", date: "2023-09-10" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-10" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-10" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  { nomfichier: "khalid", category: "developpeur", date: "30-04/2024" },
];

// Variables de données
const searchTerm = ref("");
const selectedCategory = ref("");
// const selectedDate = ref('');
const searching = ref(false);
const startDate = ref("");
const endDate = ref("");
//Fonction de filtrage des éléments
const filteredItems = computed(() => {
  let filtered = items;

  // if (startDate.value !== "" && endDate.value !== "") {
  //   filtered = filtered.filter((item) => {
  //     const itemDate = new Date(item.date);
  //     return itemDate >= new Date(startDate.value) && itemDate <= new Date(endDate.value);
  //   });
  // }

  // if (selectedCategory.value) {
  //   filtered = filtered.filter((item) => item.category === selectedCategory.value);
  // }

  //   // if (searchTerm.value.trim().length < 3) {
  //   // return filtered;
  //   // }
  //   if (searchTerm.value.trim() !== "") {
  //     filtered = filtered.filter((item) =>
  //       item.nomfichier.toLocaleLowerCase().includes(searchTerm.value.toLocaleLowerCase())
  //     );
  //   }

  return filtered;
});

// Récupération des catégories uniques ()
const uniqueCategories = computed(() => [...new Set(items.map((item) => item.category))]);

// permet d'afficher les items dans le tableau
$(document).ready(() => {
  const table = $("#table");
  table.bootstrapTable({ data: items });
});

function refreshTable() {
  const table = $("#table");
  // const items = [
  //   { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  //   { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  //   { nomfichier: "Larry", category: "the Bird", date: "2005-08-10" },
  //   { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  //   { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  //   { nomfichier: "Larry", category: "the Bird", date: "2005-08-12" },
  // ]
 
  //permet d'avoir  toutes les valeurs du tableau
  const els = document.querySelectorAll("table thead th")
  console.log(els)
  const myObjEntete = []
  for (let i = 0; i < els.length; i++) {
    myObjEntete.push(els[i].getAttribute("data-field"))
  }
  console.log(myObjEntete)
  const trs = document.querySelectorAll("table tbody tr")
  trs.forEach((tr) => {
    const tds = tr.querySelectorAll("td")
    tds.forEach((td) => {
      console.log(td.innerHTML)
    });
  });
  // console.log(els2)
  // table.bootstrapTable( 'load', items);
}
</script>

<style lang="scss" scoped>
.fixer {
  position: fixed;
}

.box {
  display: flex;
  align-items: center;
}

.input-container {
  position: relative;
  margin-right: 20px;
}

.error {
  color: #d30000;
}
.form-control {
}

.bgg {
  background-color: #ddd0c8;
}

.generate {
  margin-left: auto;
  margin-right: auto;
}

// .table {
//   width: 100vw;
//   border-collapse: collapse;
// }
.error-message {
  color: #ff8458; /* Orange */
  font-size: 14px;
  margin-top: 5px;
  position: fixed;
}

th,
td {
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
