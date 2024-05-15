import http from 'http';
import fs from 'fs';
import { IncomingForm, Fields, Files, File } from 'formidable';

const server = http.createServer((req, res) => {
  if (req.url && req.method === 'POST') {
    const form = new IncomingForm({
      uploadDir: '/api/bdd/uploads', // Définir le dossier de destination pour les fichiers téléchargés
    });

    // Analyser le formulaire entrant
   form.parse(req, (err, fields: Fields, files: Files) => {
  if (err) {
    res.statusCode = 500;
    res.end('Une erreur est survenue lors de l\'analyse du formulaire.');
    return;
  }

  // Déplacer les fichiers téléchargés vers le dossier de destination
  const fileKeys = Object.keys(files);
  fileKeys.forEach((key) => {
    const file: File = files[key] as unknown as File;
    const oldPath = file.path;
    const newPath = path.join(__dirname, 'uploads', file.name); // Chemin de destination
    fs.renameSync(oldPath, newPath);
  });

  // Répondre au client
  res.statusCode = 200;
  res.end('Fichiers reçus et enregistrés avec succès.');
});

  } else {
    res.statusCode = 404;
    res.end('Page non trouvée.');
  }
});

// Écouter sur un port
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Serveur en cours d'exécution sur le port ${PORT}`);
});
