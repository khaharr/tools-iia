// import fs from "fs";
// import path from "path";
// import { zip } from "zip-a-folder";

// export default defineEventHandler(async (event) => {
//   const selectedFiles = await readBody(event);
//   const uploadsDirectory = path.join(process.cwd(), "server", "api", "uploads");
//   const zipFile = await zip(uploadsDirectory, selectedFiles);

//   return {
//     body: zipFile,
//     headers: {
//       "Content-Type": "application/zip",
//       "Content-Disposition": `attachment; filename="files.zip"`,
//     },
//   };
// });