<template>
    <div>
        <button class="btn btn-outline-secondary validerCouleur" @click="myTest" type="button" id="inputGroupFileAddon04">
            Valider
          </button>
    </div>
</template>

<script>
export default {
    name: "boutonValider",
    methods: {
    myTest() {
      alert("valide avec succés");
    },
  },
}

</script>

<style lang="css" scoped>
.validerCouleur{
  color: white;
  background-color: rgb(0, 0, 0);
}
.validerCouleur:hover{
  color: black;
  background-color: white;
}
</style>