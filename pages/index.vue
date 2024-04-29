<template>
  <div class="bgg">
    <div>
      <Date />
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
          <tr v-for="(item, index) in items" :key="index">
            <th scope="row">{{ index + 1 }}</th>
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

// Exemple de données pour le tableau
const items = [
  { nomfichier: 'Mark', category: 'Otto', date: '@mdo' },
  { nomfichier: 'Jacob', category: 'Thornton', date: '@fat' },
  { nomfichier: 'Larry', category: 'the Bird', date: '@twitter' }
];

</script>

<style lang="scss" scoped>
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
