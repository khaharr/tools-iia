import $ from 'jquery'

window.jQuery = window.$ = $
export default window.jQuery


{
  "extends": "../.nuxt/tsconfig.server.json",
  "exclude": [
    "../plugins/*.js"
  ]
}
