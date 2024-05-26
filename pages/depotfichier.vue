<template>
  <div class="bgg">
    <div class="container">
      <h1>Déposer des fichiers</h1>

      <div class="row mt-4">
        <div class="col-md-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Sélectionner les fichiers à déposer</h5>

              <input type="file" class="form-control" id="inputGroupFile01" multiple @change="uploadFiles" accept=".jpg, .jpeg, .png,.doc,.docx,.xml,.pdf,.org,.csv,.sql,.txt,.tar.gz,.tar,.doc,.docx,.xls,.xlsx,.mp3,.mp4,html,.json," />

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

        <div >
          <div class="card mt-3" v-if="depositedFiles.length > 0">
            <div class="card-body">
              <h3 class="card-title">Fichiers déposés</h3>
              <div class="row mt-4">
                <div v-for="(file, index) in depositedFiles" :key="index" class="col-6 mb-5">
                  <div class="card h-100">
                    <div class="card-body">
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

              <div class="mt-4">
                <div class="progress" role="progressbar" aria-label="Animated striped example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                  <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 0%"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="alert alert-info mt-4 w-50" role="alert" v-else>Aucun fichier déposé.</div>
        </div>
      </div>

      <div class="mt-4" v-if="fileStatuses.length > 0">
        <h3>Statuts des fichiers envoyés</h3>
        <ul class="list-group">
          <li v-for="(status, index) in fileStatuses" :key="index" :class="{'list-group-item-success': status.success, 'list-group-item-danger': !status.success}" class="list-group-item d-flex justify-content-between align-items-center">
            {{ status.name }}
            <span v-if="status.success" class="badge bg-success">✔️</span>
            <span v-else class="badge bg-danger">❌ {{ status.error }}</span>
          </li>
        </ul>
      </div>
      
    </div>
  </div>
</template>
<script setup lang="ts">

const categories = ref<string[]>(["Catégorie 1", "Catégorie 2", "Catégorie 3"]);
const selectedCategory = ref<string>("");
const depositedFiles = ref<{ name: string; category: string; file: File }[]>([]);
const fileStatuses = ref<{ name: string; success: boolean; error?: string }[]>([]);

const uploadFiles = () => {
  if (selectedCategory.value === "") {
    alert("Veuillez sélectionner une catégorie.");
    return;
  }

  const input = document.querySelector('input[type="file"]') as HTMLInputElement;
  const files = Array.from(input.files as FileList);
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
  const progressBar = document.querySelector(".progress-bar") as HTMLElement;
  fileStatuses.value = []; // Reset status

  let totalSize = 0;
  let uploadedSize = 0;

  depositedFiles.value.forEach(file => {
    totalSize += file.file.size;
  });

  for (const file of depositedFiles.value) {
    const formData = new FormData();
    formData.append("file", file.file);

    try {
      const response = await fetch("/api/bdd/depot", {
        method: "POST",
        body: formData,
      });

      const responseData = await response.json();

      if (!response.ok || !responseData.success) {
        throw new Error(responseData.message || 'Erreur inconnue');
      }

      uploadedSize += file.file.size;
      const progress = (uploadedSize / totalSize) * 100;
      progressBar.style.width = `${progress}%`;
      progressBar.setAttribute("aria-valuenow", progress.toString());

      fileStatuses.value.push({
        name: file.name,
        success: true,
      });
    } catch (error) {
      console.error("Erreur lors de l'envoi des fichiers:", error);
      fileStatuses.value.push({
        name: file.name,
        success: false,
        error: error instanceof Error ? error.message : String(error)
      });
    }
  }

  //  une seconde pour s'assurer que la barre de progression atteint 100%
  setTimeout(() => {
    if (fileStatuses.value.every(status => status.success)) {
      alert("Fichiers envoyés avec succès");
    } else {
      alert("Certains fichiers n'ont pas été envoyés correctement");
    }

    depositedFiles.value = [];
    progressBar.style.width = '0%'; // Réinitialiser la barre de progression
  }, 1000); // Délai de 1 seconde avant d'afficher l'alerte
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
.card-body:hover {
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

.alert-info {
  background-color: #d9edf7;
  color: #31708f;
  border-color: #bce8f1;
}

.text-success {
  color: green;
}

.text-danger {
  color: red;
}
</style>