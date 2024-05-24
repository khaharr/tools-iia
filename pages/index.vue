<template>
  <div class="bgg">
    <div class="tbl-container">
      <h1>Téléchargement de fichiers</h1>
      <div class="tbl-filters">
        <h4 class="tbl-filter-title d-flex justify-content-center">Filtre de recherche <i class="bi bi-search"></i></h4>
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
            <label class="form-label">Nom du fichier / catégorie :</label>
            <input type="text" id="customSearch" class="form-control" placeholder="rechercher" />
          </div>
          <div class="col-2" id="filter">
            <label class="form-label">Catégorie :</label>
            <select class="form-control bootstrap-table-filter-control-category">
              <option value="">Afficher tout</option>
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
              <th data-field="id">ID</th>
              <th data-field="nomfichier" data-searchable="true" data-click-to-select="true">Nom fichier</th>
              <th data-field="category" data-filter-control="select">Catégorie</th>
              <th data-field="date" data-sortable="true" data-searchable="false">Date mise en ligne</th>
            </tr>
          </thead>
        </table>
        <div class="text-center mb-4">
          <button class="btn btn-primary validerCouleur " @click="generateFile" type="button" id="inputGroupFileAddon04" data-dismiss="alert">
            Générer Fichiers
          </button>
        </div>
        <div v-if="errorMessage" class="alert alert-danger" role="alert">
          {{ errorMessage }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref, type Ref } from 'vue';
import 'bootstrap';

// Interface pour les items
interface Item {
  id: number;
  nomfichier: string;
  category: string;
  date: string;
}

const items: Ref<Item[]> = ref([]);
const dateFrom: Ref<string | null> = ref(null);
const dateTo: Ref<string | null> = ref(null);
const errorMessage: Ref<string | null> = ref(null);

onMounted(async () => {
  try {
    const response = await fetch('/api/bdd/tableau');
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.statusMessage || 'Erreur lors de la récupération des données');
    }

    const data: Item[] = await response.json();
    console.log("Data récupérées de l'API:", data);

    if (Array.isArray(data) && data.length > 0) {
      items.value = data;
      console.log("Items données", items.value);

      const table = $('#table');
      table.bootstrapTable({
        data: items.value,
      });
    } else {
      console.error("Données récupérées non valides");
    }
  } catch (error: any) {
    console.error('Erreur lors de la récupération des données:', error.message);
    errorMessage.value = 'Erreur lors de la récupération des données. Veuillez réessayer plus tard. ' + error.message;
  }
});

const applyDateFilter = () => {
  const table = $('#table');
  table.bootstrapTable('load', items.value);
  table.bootstrapTable(
    'filterBy',
    {},
    {
      filterAlgorithm: (row: Item, filters: any) => {
        const itemDate = new Date(row.date);
        const fromDate = dateFrom.value ? new Date(dateFrom.value) : null;
        const toDate = dateTo.value ? new Date(dateTo.value) : null;

        if (!fromDate && !toDate) {
          return true;
        }

        if (!fromDate) {
          return itemDate <= toDate!;
        }

        if (!toDate) {
          return itemDate >= fromDate!;
        }

        return itemDate >= fromDate && itemDate <= toDate;
      },
    }
  );
};

const generateFile = async () => {
  try {
    const selectedRows = $('#table').bootstrapTable('getSelections') as Item[];
    if (selectedRows.length === 0) {
      alert('Veuillez sélectionner au moins un fichier.');
      return;
    }

    const filenames = selectedRows.map(row => row.nomfichier);

    const response = await fetch('/api/bdd/donload', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ filenames }),
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.statusMessage || 'Erreur lors du téléchargement des fichiers.');
    }

    const blob = await response.blob();
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'FichiersPaiement.zip';
    document.body.appendChild(a);
    a.click();
    a.remove();
  } catch (error: any) {
    console.error('Erreur lors de la génération du fichier ZIP:', error.message);
    errorMessage.value = 'Erreur lors de la génération du fichier ZIP. ' + error.message;
  }
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

.table {
  background-color: rgb(231, 231, 231);
}
.filter-title {
  color: rgb(0, 0, 0);
  animation: slide-in 0.5s ease-in-out;

  .bi-search {
    margin-left: 5px;
  }
}

h1 {
  font-size: 32px;
  font-family: Arial, Helvetica, sans-serif;
  color: rgb(0, 0, 0);
  padding: 16px;
  font-weight: lighter;
  box-shadow: 2px 2px 6px #9e9e9e;
  text-align: center;
  display: block;
  border-radius: 20px;
}

.fixer {
  position: fixed;
}

.bgg {
  background-color: #ddd0c8;
  padding-bottom: 20px;
}
</style>
