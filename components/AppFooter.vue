<template>
  <div class="bas">
    <div class="pt-5 pb-5 footer">
      <div class="container">
        <div class="row">
          <div class="col-lg-5 col-xs-12 about-company">
            <h2>Contact</h2>
            <p class="pr-5 text-muted">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac ante mollis quam tristique convallis</p>
            <p>
              <NuxtLink to="#"><i class="fa fa-facebook-square mr-1"></i></NuxtLink>
              <NuxtLink to="#"><i class="fa fa-linkedin-square"></i></NuxtLink>
            </p>
          </div>
          <div class="col-lg-3 col-xs-12 links">
            <h4 class="mt-lg-0 mt-sm-3">Liens</h4>
            <ul class="list-unstyled">
              <li><NuxtLink to="/">télechargement</NuxtLink></li>
              <li><NuxtLink to="/depotfichier">dépot de fichiers</NuxtLink></li>
              <li><NuxtLink to="/paiement">paiement</NuxtLink></li>
              <li><NuxtLink to="/jeuDonnees">jeux de données</NuxtLink></li>
            </ul>
          </div>
          <div class="col-lg-4 col-xs-12 location">
            <h4 class="mt-lg-0 mt-sm-4">Localisation</h4>
            <p></p>
            <p class="mb-0"><i class="fa fa-phone mr-3"></i>(541) 754-3010</p>
            <p><i class="fa fa-envelope-o mr-3"></i>DGFIP@gmail.com</p>
          </div>
        </div>
        <div class="row mt-5">
          <div class="col copyright">
            <p class="text-muted"><small>© All Rights Reserved.</small></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// Votre script reste inchangé
</script>

<style lang="scss" scoped>
.bas {
  background-color: #ddd0c8; /* Utiliser la même couleur de fond que la page */
  color: #333; /* Couleur du texte en harmonie avec le fond */
  box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1); /* Couleur du texte en harmonie avec le fond */
}
h2{
  color: rgb(250, 241, 241);
}
h4{
  color: rgb(250, 241, 241);
}
.footer {
  color: #333; /* Couleur du texte */
  background-color: #ddd0c8; /* Fond coordonné avec la page */
  border-top: 1px solid rgba(0, 0, 0, 0.1); 
  .links {
    ul {
      list-style-type: none;
      padding: 0;
    }
    li {
      a {
        color: #333; /* Couleur du texte des liens */
        text-decoration: none;
        transition: color 0.2s;
        &:hover {
          color: #4180CB; /* Couleur au survol */
        }
      }
    }
  }
  
  .about-company {
    i {
      font-size: 25px;
      margin-right: 10px;
    }
    a {
      color: #333;
      transition: color 0.2s;
      &:hover {
        color: #4180CB;
      }
    }
  }

  .location {
    i {
      font-size: 18px;
      margin-right: 10px;
    }
  }

  .copyright {
    border-top: 1px solid rgba(0, 0, 0, 0.1);
    p {
      margin-top: 10px;
    }
  }
}
</style>
