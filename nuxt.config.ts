//https://nuxt.com/docs/api/nuxt-config
export default defineNuxtConfig({
  ssr:false,
  devtools: { enabled: true },
  css: ["bootstrap/dist/css/bootstrap.min.css",
  "bootstrap-icons/font/bootstrap-icons.min.css",
  "bootstrap-table/dist/bootstrap-table.min.css"
  ], // add
  vite: {
    define: {
      "process.env.DEBUG": true,
    },
  },
  
  app: {
    pageTransition: { name: 'page', mode: 'out-in' },
    head: {
      script: [
        {
          
          src: "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js",
          
        },
      ],
    },
  },
});

// export default defineNuxtConfig({
//   ssr:true,
//   devtools: { enabled: true },
//   css: ["bootstrap/dist/css/bootstrap.min.css",
//   "bootstrap-icons/font/bootstrap-icons.min.css",
//   "bootstrap-table/dist/bootstrap-table.min.css"
//   ]
// });