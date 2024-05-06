<template>
  <div class="search-container">
    <div class="search-header">
      <h1> télechargement de fichiers</h1>
      <h4 class="filter-title">filtre de recherche <i class="bi bi-search"></i></h4>
    </div>
    <div class="search-filters">
      <div class="row justify-content-center">
        <div class="col-2">
          <label for="dateFrom" class="form-label">Date de début :</label>
          <input type="date" class="form-control" id="dateFrom" v-model="dateFrom">
        </div>
        <div class="col-2">
          <label for="dateTo" class="form-label">Date de fin :</label>
          <input type="date" class="form-control" id="dateTo" v-model="dateTo">
        </div>
        <div class="col-2">
        <button class="btn btn-outline-secondary form-control validerCouleur" @click="generateFile" type="button" id="inputGroupFileAddon04">
            Générer Fichier
          </button></div>
      </div>
    </div>
    <div>
      <table
        id="table"
        data-toggle="table"
        data-pagination="true"
        data-cookie="true"
        data-cookie-id-table="saveId"
        data-filter-control="true"
        data-click-to-select="true"
        data-search = "true"
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
        <button class="btn btn-outline-secondary validerCouleur" @click="generateFile" type="button" id="inputGroupFileAddon04">
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

// fonction date filtre
const filteredItems = computed(() => {
  return items.value.filter(item => {
    const itemDate = new Date(item.date)
    if (!dateFrom.value || !dateTo.value) {
      return true
    }
    const fromDate = new Date(dateFrom.value)
    const toDate = new Date(dateTo.value)
    return itemDate >= fromDate && itemDate <= toDate
  })
})
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

const applyDateFilter = () => {
  const table = $("#table")
  table.bootstrapTable('filterBy', {
    date: {
      FROMDATE: dateFrom.value,
      TODATE: dateTo.value
    }
  })
}

const generateFile = () => {
  console.log($('table').bootstrapTable('getData'))
  console.log($('table').bootstrapTable('getData').filter((item) => item.check))
  // Générez le fichier ici
}
</script>

<style lang="scss" scoped>


</style>
