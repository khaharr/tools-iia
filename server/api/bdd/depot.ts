import { defineEventHandler } from 'h3';
import { readMultipartFormData } from 'h3';
import fs from 'fs';
import path from 'path';

export default defineEventHandler(async (event) => {
  const formData = await readMultipartFormData(event);
  
  if (formData === undefined || formData.length === 0) {
    return { message: 'Aucun fichier trouvé.' };
  }
 
  try {
    const uploadsDirectory = path.join(process.cwd(), 'server','api', 'bdd', 'uploads');

    for (const file of formData) {
      const fileBuffer: Buffer = file.data;
      const fileContent = fileBuffer.toString('utf8');
      
      if (file.filename === undefined){
        return "error"
      };
      const filePath = path.join(uploadsDirectory, file.filename);

      // Écrire le contenu du fichier dans le fichier de destination
      fs.writeFileSync(filePath, fileContent, 'utf8');
      
      console.log(`Fichier enregistré: ${file.filename}`);
    }

    return { message: 'Fichiers envoyés avec succès!' };
  } catch (error) {
    console.error('Erreur lors de l\'enregistrement des fichiers :', error);
    return { message: 'Erreur lors de l\'enregistrement des fichiers.' };
  }
});
