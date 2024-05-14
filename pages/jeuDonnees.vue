<template>
  <div class="container mt-4">
    <h1 class="mb-4">Générer des jeux de données pour la MOA</h1>
    <div class="mb-4">
      <label for="invoiceType" class="form-label">Type de facture:</label>
      <select id="invoiceType" class="form-select" v-model="selectedInvoiceType">
        <option value="tiers_malade_with_reference">Titre EPS avec référence tiers malade</option>
        <option value="tiers_malade_without_reference">Titre EPS sans référence tiers malade</option>
        <option value="rnf">Titre RNF</option>
        <option value="roles">roles</option>
        <option value="titres">Titres</option>

      </select>
    </div>
    <button class="btn btn-primary" @click="generateInvoices">Générer un fichier de factures</button>
  </div>
</template>

<script setup>

</script>

<style lang="scss" scoped>
.container {
  max-width: 800px;
}
</style>