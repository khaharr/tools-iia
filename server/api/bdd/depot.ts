
import fs from 'fs';

export default defineEventHandler(async (event) => {

  // const {formData} = ge
const t = await readBody(event)
console.log(t)  
// Déplacer les fichiers téléchargés vers le dossier de destination
  // const fileKeys = Object.keys(files);
  // fileKeys.forEach((key) => {
  //   const file: File = files[key] as unknown as File;
  //   const oldPath = file.path;
  //   const newPath = path.join(__dirname, 'uploads', file.name); // Chemin de destination
  //   fs.renameSync(oldPath, newPath);
  // });




})