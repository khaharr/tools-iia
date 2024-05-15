<template>
  <div class="container mt-4">
    <h1 class="mb-4">Générer des jeux de données pour la MOA</h1>
    <div class="mb-4">
      <label for="fileType" class="form-label">Type de fichier:</label>
      <select id="fileType" class="form-select" v-model="selectedFileType">
        <option v-for="fileType in fileTypes" :key="fileType.value" :value="fileType.value">
          {{ fileType.label }}
        </option>
      </select>
    </div>
    <button class="btn btn-primary" @click="downloadFile">Télécharger le fichier</button>
  </div>
</template>

<script setup>
const fileTypes = [
  { value: '2023-11-21_select_eps_avec_tiers_malade', label: '2023-11-21_select_eps_avec_tiers_malade' },
  { value: 'tiers_malade_without_reference', label: 'Titre EPS sans référence tiers malade' },
  { value: 'rnf', label: 'Titre RNF' },
  { value: 'roles', label: 'Rôles' },
  { value: 'titres', label: 'Titres' },
]

const selectedFileType = ref('')

function downloadFile() {
  const fileName = `${selectedFileType.value}.csv`
  const filePath = `example-Jeu-De-Donnees/${fileName}`
  const link = document.createElement('a')
  link.href = filePath
  link.download = fileName
  link.click()
}
</script>

<style lang="scss" scoped>
.container {
  max-width: 800px;
}
</style>