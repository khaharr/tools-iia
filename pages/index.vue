<template>
  <div class="search-container">
    <div class="search-header">
      <h1> télechargement de fichiers</h1>
      <h4 class="filter-title ">filtre de recherche <i class="bi bi-search"></i></h4>
    </div>
    <div class="search-filters">
      <div class="row justify-content-center">
        <div class="col-2">
          <label for="dateFrom" class="form-label">Date de début :</label>
          <input type="date" class="form-control" id="dateFrom" v-model="dateFrom" @change="applyDateFilter">
        </div>
        <div class="col-2">
          <label for="dateTo" class="form-label">Date de fin :</label>
          <input type="date" class="form-control" id="dateTo" v-model="dateTo" @change="applyDateFilter">
        </div>
        <div class="col-2">

        </div>
      </div>
    </div>
    <div class="w-75 m-auto">
      
      <table
        id="table"
        data-toggle="table"
        data-pagination="true"
        data-cookie="true"
        data-cookie-id-table="saveId"
        data-filter-control="true"
        data-click-to-select="true"
      >
        <thead class="table-dark">
          <tr>
            <th data-checkbox="true" data-field="check"></th>
            <th  data-field="id">id</th>
            <th data-field="nomfichier" data-searchable="true" data-click-to-select="true">nom fichier</th>
            <th data-field="category" data-searchable="false">category</th>
            <th data-field="date" data-sortable="true" data-searchable="false">date mise en ligne</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="position-absolute  start-50 translate-middle" >
      <div>
        <button class="btn btn-primary validerCouleur" @click="generateFile" type="button" id="inputGroupFileAddon04">
            Générer Fichier
          </button>
    </div>
      </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'


const selectedRows = []
const items = ref([])
const dateFrom = ref(null)
const dateTo = ref(null)


// fonction permettant d'afficher les données de la bdd dans la table
onMounted(async () => {
  const data = await useFetch('/api/bdd/bdd')

  items.value = data
  console.log(items.value.data)
  const table = $("#table");
  table.bootstrapTable({
    data: items.value.data,
  });
});
// fonction date filtre

const applyDateFilter = () => {
  const table = $("#table")
  table.bootstrapTable('load', items.value.data)
  table.bootstrapTable( 'filterBy',{}, {'filterAlgorithm': (row, filters)=>{
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
  }
})
}

const generateFile = () => {
  alert(JSON.stringify($('table').bootstrapTable('getData').filter((item) => item.check)) )
  // Générez le fichier ici
}
</script>

<style lang="scss" scoped>


</style>
