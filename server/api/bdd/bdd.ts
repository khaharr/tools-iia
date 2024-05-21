import { promises as fs } from 'fs';
import path from 'path';

export default defineEventHandler(async (event) => {
  const uploadDir = path.join(process.cwd(), 'server', 'api', 'bdd', 'uploads');
  try {
    const files = await fs.readdir(uploadDir);

    const fileData = await Promise.all(
      files.map(async (file, index) => {
        const filePath = path.join(uploadDir, file);
        const stats = await fs.stat(filePath);
        return {
          id: index + 1,
          nomfichier: file,
          category: '???',
          date: stats.mtime.toISOString(),
        };
      })
    );

    return fileData;
  } catch (error) {
    console.error('destination upload incorrect ', error);
    return [];
  }
});
