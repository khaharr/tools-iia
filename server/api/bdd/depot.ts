import fs from 'fs';
import path from 'path';

export default defineEventHandler(async (event) => {
  const formData = await readMultipartFormData(event);

  if (!formData || formData.length === 0) {
    return { message: 'Aucun fichier trouvé.', success: false, files: [] };
  }
  //emplacement dépot de fichier dans le répértoire
  const uploadsDirectory = path.join(process.cwd(), 'server', 'api', 'bdd', 'uploads');
  const resultFiles: { name: string; success: boolean; error?: string; }[] = [];

  // Créer le répertoire s'il n'existe pas
  try {
    if (!fs.existsSync(uploadsDirectory)) {
      fs.mkdirSync(uploadsDirectory, { recursive: true });
    }
  } catch (error) {
    const errorMessage = `Erreur lors de la création du répertoire de destination "${uploadsDirectory}".`;
    console.error(errorMessage, error);
    return { message: errorMessage, success: false, files: resultFiles };
  }
  //gestion d'erreur
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

    return { message: 'Fichiers traités.', success: true, files: resultFiles };
  } catch (error) {
    console.error('Erreur lors de l\'enregistrement des fichiers :', error);
    return { message: 'Erreur lors de l\'enregistrement des fichiers.', success: false, files: resultFiles };
  }
});
