<template>
  <div class="bgg">
    <div class="tbl-container">
        <h1>Téléchargement de fichiers</h1>
      <div class="tbl-filters">
        
        <h4 class="tbl-filter-title d-flex justify-content-center">Filtre de recherche <i class=" bi bi-search"></i></h4>
       
        <div class="row justify-content-center">
          <div class="col-2">
            <label for="dateFrom" class="form-label">Date de début :</label>
            <input type="date" class="form-control" id="dateFrom" v-model="dateFrom" @change="applyDateFilter" />
          </div>
          <div class="col-2">
            <label for="dateTo" class="form-label">Date de fin :</label>
            <input type="date" class="form-control" id="dateTo" v-model="dateTo" @change="applyDateFilter" />
          </div>
          <div class="col-2">
            <label class="form-label">nom du fichier / categorie :</label>
            <input type="text" id="customSearch" class="form-control" placeholder="rechercher" />
          </div>

          <div class="col-2 " id="filter">
            <label class="form-label">categorie :</label>

            <select class="form-control bootstrap-table-filter-control-category">
            <option  value="">afficher tout</option>
            </select>

          </div>
        </div>
      </div>


    <div class="w-75 m-auto">
      <table
        id="table"
        data-filter-control-container="#filter"
        data-toggle="table"
        data-pagination="true"
        data-cookie="true"
        data-search="true"
        data-cookie-id-table="saveId"
        data-filter-control="true"
        data-search-highlight="true"
        data-click-to-select="true"
        data-search-selector="#customSearch"
      >
        <thead class="table-dark">
          <tr>
            <th data-checkbox="true" data-field="check"></th>
            <th data-field="id">id</th>
            <th data-field="nomfichier" data-searchable="true" data-click-to-select="true">nom fichier</th>
            <th data-field="category"  data-filter-control="select">category</th>
            <th data-field="date" data-sortable="true" data-searchable="false">date mise en ligne</th>
          </tr>
        </thead>
      </table>
      <div class="">
        <button class="btn btn-primary validerCouleur" @click="generateFile" type="button" id="inputGroupFileAddon04"  data-dismiss="alert">
          Générer Fichier
        </button>
    </div>
    </div>
    
  </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";

const selectedRows = [];
const items = ref([]);
const dateFrom = ref(null);
const dateTo = ref(null);
const selectedCategory = ref("");


onMounted(async () => {
  const data = await useFetch("/api/bdd/bdd");

  items.value = data;
  const table = $("#table");
  table.bootstrapTable({
    data: items.value.data,
  });
});

// fonction date filtre

const applyDateFilter = () => {
  const table = $("#table");
  table.bootstrapTable("load", items.value.data);
  table.bootstrapTable(
    "filterBy",
    {},
    {
      filterAlgorithm: (row, filters) => {
        const itemDate = new Date(row.date);
        const fromDate = dateFrom.value ? new Date(dateFrom.value) : null;
        const toDate = dateTo.value ? new Date(dateTo.value) : null;

        if (!fromDate && !toDate) {
          return true;
        }

        if (!fromDate) {
          return itemDate <= toDate;
        }

        if (!toDate) {
          return itemDate >= fromDate;
        }

        return itemDate >= fromDate && itemDate <= toDate;
      },
    }
  );
};
const generateFile = async () => {
  // Récupère les lignes sélectionnées de la table
  const selectedRows = $("#table").bootstrapTable("getSelections");
  const data = await useFetch("/api/bdd/bdd.insert", {
    method: "POST",
    body: JSON.stringify(selectedRows), // Convertit le tableau selectedRows en une chaîne JSON
  });

  // Met à jour le tableau items avec les nouvelles données provenant du serveur
  items.value = data;

  // Met à jour la table avec les nouvelles données
  const table = $("#table");
  table.bootstrapTable({ data: items.value.data, });
  alert('fichier mis dans les télechargement')
  
};

</script>

<style lang="scss" scoped>

.tbl-filters {
  margin: 20px auto;
  padding: 20px;
  background-color: #ddd0c8;
  width: 70vw;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-row {
  margin-bottom: 20px;
}

.form-label {
  margin-bottom: 10px;
}

.form-control {
  height: calc(1.5em + 0.75rem + 2px);
  padding: 0.375rem 0.75rem;
  font-size: 0.875rem;
  line-height: 1.5;
}
.filter-title {
  color: rgb(0, 0, 0);
  animation: slide-in 0.5s ease-in-out;
 
  .bi-search {
    margin-left: 5px;
  }
}
h1
{
  
  font-size: 32px;
  font-family:Arial, Helvetica, sans-serif;
  color: rgb(0, 0, 0);
  padding:16px;
  font-weight:lighter;
  box-shadow:2px 2px 6px #9e9e9e;  
  text-align:center;
  display:block;
  border-radius: 20px;
}
.fixer {
  position: fixed;
}

.bgg {
  background-color: #ddd0c8;
}



</style>
