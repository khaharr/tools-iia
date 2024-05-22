
import fs from 'fs';
import path from 'path';

export default defineEventHandler(async (event) => {
  const formData = await readMultipartFormData(event);
  
  if (!formData || formData.length === 0) {
    return { message: 'Aucun fichier trouvé.', files: [] };
  }

  const uploadsDirectory = path.join(process.cwd(), 'server', 'api', 'bdd', 'uploads');
  const resultFiles = [];

  try {
    for (const file of formData) {
      const fileBuffer: Buffer = file.data;
      if (!file.filename) {
        const errorMessage = 'Le nom du fichier est indéfini.';
        console.error(errorMessage);
        resultFiles.push({ name: 'Indéfini', success: false, error: errorMessage });
        continue;
      }

      const filePath = path.join(uploadsDirectory, file.filename);
      try {
        fs.writeFileSync(filePath, fileBuffer);
        resultFiles.push({ name: file.filename, success: true });
      } catch (error) {
        const errorMessage = `Erreur lors de l'enregistrement du fichier: ${file.filename}`;
        console.error(errorMessage, error);
        resultFiles.push({ name: file.filename, success: false, error: errorMessage });
      }
    }

    return { message: 'Fichiers traités.', files: resultFiles };
  } catch (error) {
    console.error('Erreur lors de l\'enregistrement des fichiers :', error);
    return { message: 'Erreur lors de l\'enregistrement des fichiers.', files: resultFiles };
  }
});