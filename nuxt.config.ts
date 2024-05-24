//https://nuxt.com/docs/api/nuxt-config
export default defineNuxtConfig({
  ssr:true,
  devtools: { enabled: true },
  css: ["bootstrap/dist/css/bootstrap.min.css",
  "bootstrap-icons/font/bootstrap-icons.min.css",
  "bootstrap-table/dist/bootstrap-table.min.css"
  ]
});


