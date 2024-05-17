<template>
  <div class="bgg">
    <div class="container ">
      <h1>Déposer des fichiers</h1>

      <div class="row mt-4">
        <div class="col-md-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Sélectionner les fichiers à déposer</h5>

              <input type="file" class="form-control" id="inputGroupFile01" multiple @change="uploadFiles" />

              <div class="mt-3">
                <label for="categorySelect" class="form-label">Choisir la catégorie :</label>
                <select class="form-select" id="categorySelect" v-model="selectedCategory">
                  <option value="">Sélectionner une catégorie</option>

                  <option v-for="category in categories" :value="category" :key="category">{{ category }}</option>
                </select>
              </div>

              <button class="btn btn-primary mt-3" @click="uploadFiles">Déposer les fichiers</button>
            </div>
          </div>
        </div>

        <div class="ICI">
          <div class="card mt-3" v-if="depositedFiles.length > 0">
            <div class="card-body ">
              <h3 class="card-title d-flex d-flex justify-content-center">Fichiers déposés</h3>
              <div class="row mt-4">
                <div v-for="(file, index) in depositedFiles" :key="index" class="col-6 mb-5">
                  <div class="card h-100">
                    <div class="card-body ">
                      <h6>
                        {{ file.name }}
                        <button class="btn btn-danger btn-sm" @click="removeFile(index)">Supprimer</button>
                      </h6>
                      <span class="badge bg-secondary">{{ file.category }}</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="d-flex justify-content-center">
                <button class="btn btn-success mt-3" @click="sendFilesToServer">Envoyer les fichiers</button>
              </div>

              <div>
                <p class="mt-4"></p>

                <div
                  class="progress"
                  role="progressbar"
                  aria-label="Animated striped example"
                  aria-valuenow="75"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 0%"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="alert alert-info mt-4 w-50" role="alert" v-else>Aucun fichier déposé.</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

const categories = ref<string[]>(["Catégorie 1", "Catégorie 2", "Catégorie 3"]);
const selectedCategory = ref<string>("");
const depositedFiles = ref<{ name: string; category: string; file: File }[]>([]);
const uploadedFiles = ref<File[]>([]);

const uploadFiles = () => {
  if (selectedCategory.value === "") {
    return;
  }

  const input = document.querySelector('input[type="file"]') as HTMLInputElement;
  const files = Array.from(input.files as FileList);
  console.log(files);
  if (files.length === 0) {
    alert("Veuillez sélectionner au moins un fichier.");
    return;
  }

  files.forEach((file) => {
    depositedFiles.value.push({ name: file.name, category: selectedCategory.value, file });
  });

  input.value = "";
};

const removeFile = (index: number) => {
  depositedFiles.value.splice(index, 1);
};
const sendFilesToServer = async () => {
  const formData = new FormData();
  let totalSize = 0;

  depositedFiles.value.forEach((file, i) => {
    formData.append("files" + i, file.file);
    totalSize += file.file.size;
  });

  let uploadedSize = 0;

  for (const file of depositedFiles.value) {
    try {
      const response = await useFetch("/api/bdd/depot", {
        method: "POST",
        body: formData,
      });

      uploadedSize += file.file.size;
      const progress = (uploadedSize / totalSize) * 100;
      // console.log(progress );

      // Mettre à jour la barre de progression
      const progressBar = document.querySelector(".progress-bar") as HTMLElement;
      progressBar.style.transition = "width 0.1s ease";
      progressBar.style.width = `${progress}%`;
      progressBar.setAttribute("aria-valuenow", progress.toString());

      // Attendre 50 millisecondes avant de continuer
      await new Promise((resolve) => setTimeout(resolve, 50));
    } catch (error) {
      console.error("Erreur lors de l'envoi des fichiers:", error);
    }

    // Supprimer le fichier envoyé de la formData
    formData.delete("files" + depositedFiles.value.indexOf(file));
  }
  alert("fichier envoyé avec succés");
  console.log("Fichiers envoyés avec succès:", formData);
  depositedFiles.value = [];
};
</script>



<style scoped>
.bgg {
  background-color: #ddd0c8;
}

.card {
  background-color: #ebe7e7;
  border: none;
  border-radius: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-body {
  padding: 1.5rem;
  transition: transform 250ms;
}
.card-body:hover{
  transform: translateY(-10px);
}

.card-body h6 {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.card-body h6 button {
  margin-left: 10px;
}

.badge {
  font-size: 12px;
  padding: 5px 10px;
  border-radius: 50px;
  background-color: #337ab7;
  color: #fff;
}

.badge.bg-secondary {
  background-color: #6c757d;
}
</style>
