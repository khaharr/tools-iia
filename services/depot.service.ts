import { fileUpload } from 'h3';

export const fileUpload = async (event) => {
  const upload = fileUpload({
    directory: 'uploads/',
    limit: 10000000, // 10 MB
  });

  await upload(event);

  const files = [];
  for (const file of upload.files) {
    files.push({
      originalname: file.originalname,
      category: file.fields.category,
    });
  }

  return files;
};