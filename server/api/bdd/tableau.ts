import { promises as fs } from 'fs';
import path from 'path';
import { defineEventHandler, createError } from 'h3';

export default defineEventHandler(async (event) => {
  const uploadDir = path.join(process.cwd(), 'server', 'api', 'bdd', 'uploads');
  
  try {
    const files = await fs.readdir(uploadDir);
    
    if (!files.length) {
      throw createError({ statusCode: 404, statusMessage: 'Aucun fichier trouvé dans le répertoire' });
    }

    const fileData = await Promise.all(
      files.map(async (file, index) => {
        try {
          const filePath = path.join(uploadDir, file);
          const stats = await fs.stat(filePath);
          return {
            id: index + 1,
            nomfichier: file,
            category: '???',
            date: stats.mtime.toISOString(),
          };
        } catch (error) {
          console.error(`Erreur lors de la récupération des informations du fichier: ${file}`, error);
          throw createError({ statusCode: 500, statusMessage: `Erreur lors de la récupération des informations du fichier: ${file}` });
        }
      })
    );

    return fileData;
  } catch (error) {
    console.error('Erreur lors de la récupération des fichiers du répertoire', error);
    throw createError({ statusCode: 500, statusMessage: 'Erreur lors de la récupération des fichiers du répertoire' });
  }
});