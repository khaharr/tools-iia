import fs from 'fs';
import path from 'path';
import { createToastification } from 'vue-toastification';

export default defineEventHandler(async (event) => {
  const formData = await readMultipartFormData(event);
  
  if (formData === undefined || formData.length === 0) {
    return { message: 'Aucun fichier trouvé.' };
  }
 
  try {
    // répertoire de téléchargement 
    const uploadsDirectory = path.join(process.cwd(), 'server', 'api', 'bdd', 'uploads');

    for (const file of formData) {
      const fileBuffer: Buffer = file.data;
     // vérifie si le nom du fichier est défini
      if (!file.filename) {
        console.error('Le nom du fichier est indéfini.');
        continue;
      }

      const filePath = path.join(uploadsDirectory, file.filename);

      // Écrire le contenu brut du fichier dans le fichier de destination
      fs.writeFileSync(filePath, fileBuffer);
      console.log(fileBuffer)
      console.log(`Fichier enregistré: ${file.filename}`);
    }

    return { message: 'Fichiers envoyés avec succès!' };
  } catch (error) {
    console.error('Erreur lors de l\'enregistrement des fichiers :', error);
    return { message: 'Erreur lors de l\'enregistrement des fichiers.' };
  }
});
