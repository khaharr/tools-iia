<template>
  <div class="bgg">
    <div class="p-5">
      <h3>filtre de recherche <i class="bi bi-search"></i></h3>
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
      </table>
    </div>
    <BoutonGenerer @click="generateFile" />
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useBdd } from '~/composables/useBdd'

const selectedRows = []
const items = ref([])

onMounted(async () => {
  const data = await useBdd.fetchAllData()
  items.value = data
  const table = $("#table");
  table.bootstrapTable({
    data: items.value,
    onCheck: (row) => {
      selectedRows.push(row);
    },
    onUncheck: (row) => {
      const index = selectedRows.indexOf(row);
      if (index !== -1) {
        selectedRows.splice(index, 1);
      }
    }
  });
});

const generateFile = () => {
  console.log(selectedRows);
  // Générez le fichier ici
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
