import fs from 'fs';
import path from 'path';
import { defineEventHandler, createError, readBody } from 'h3';
import archiver from 'archiver';

export default defineEventHandler(async (event) => {
  const body = await readBody(event); //readBody pour obtenir le corps de la requête et Destructure le corps de la requête pour obtenir la liste des noms de fichiers
  const { filenames } = body;

  console.log("Filenames reçus:", filenames); // Log les noms de fichiers reçus

  if (!Array.isArray(filenames) || filenames.length === 0) {
    console.error("Aucun fichier sélectionné ou format incorrect");
    throw createError({ statusCode: 400, statusMessage: 'Filenames nécessaire' });
  }

  const uploadDir = path.join(process.cwd(), 'server', 'api', 'bdd', 'uploads');
  const zipFilePath = path.join(uploadDir, 'fichier.zip');

  try {
    console.log("Création de l'archive...");
    // Créer un fichier pour diffuser les données de l'archive.
    const output = fs.createWriteStream(zipFilePath);
    const archive = archiver('zip', {
      zlib: { level: 9 } // Définir le niveau de compression.
    });

    output.on('close', () => {
      console.log(`${archive.pointer()} total bytes`);
      console.log('archiver a été finalisé et le descripteur de fichier de sortie a été fermé.');
    });

    archive.on('error', (err) => {
      console.error('Erreur de l\'archiver:', err);
      throw err;
    });
   // configure archiver pour écrire les données de l'archive dans le flux de sortie
    archive.pipe(output);

    for (const filename of filenames) {
      const filePath = path.join(uploadDir, filename);
      if (fs.existsSync(filePath)) {
        console.log(`Ajout du fichier: ${filePath}`);
        archive.file(filePath, { name: filename });
      } else {
        console.warn(`Fichier non trouvé: ${filePath}`);
      }
    }

    await archive.finalize();
    console.log("Archivage finalisé.");

    // Attendre que le flux de sortie soit fermé avant de lire le fichier ZIP
    await new Promise((resolve, reject) => {
      output.on('close', resolve);
      output.on('error', reject);
    });

    console.log("Lecture du fichier ZIP généré...");
    // Lire le fichier ZIP généré
    const zipFile = await fs.promises.readFile(zipFilePath);
    console.log("Fichier ZIP généré avec succès.");
    return zipFile; // Retourner directement le fichier ZIP

  } catch (error) {
    console.error('Erreur lors de la création du fichier ZIP:', error);
    throw createError({ statusCode: 500, statusMessage: 'Erreur lors de la création du fichier ZIP' });
  }
});
