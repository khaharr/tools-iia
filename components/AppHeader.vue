<!-- composant header des pages -->

<template>
    <div>
        <nav class="navbar navbar-expand-lg navbar-light bg-whiter shadow">
                <div class="container-fluid">
                    <NuxtLink to="/"><a class="navbar-brand navText " >D.G.F.I.P</a></NuxtLink>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse " id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                          <a class="nav-link active " aria-current="page" >accueil</a>
                        </li>
                        <li class="nav-item">
                        <a class="nav-link" href="#">demande</a>
                        </li>
                        <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            liste
                        </a>
                        <ul class="dropdown-menu">
                            <li><NuxtLink to="#"><a class="dropdown-item" href="#">Action</a> </NuxtLink></li>
                            <li><a class="dropdown-item" href="#">Another action</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                        </li>
                        <li class="nav-item">
                        <a class="nav-link active" aria-curent="page" href="#">autre</a>
                        </li>
                    </ul>
                    <form class="d-flex me-4" role="search">
                        <input class="form-control me-2 "  type="search" placeholder="Recherche" aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
</svg></button>
                    </form>
                    <NuxtLink to="#"><svg xmlns="http://www.w3.org/2000/svg" width="16" id="icon" height="16" fill="currentColor" class="bi bi-person-add " viewBox="0 0 16 16" >
  <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
  <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
</svg></NuxtLink>
                          </div>
                </div>
        </nav>
    </div>
</template>

<script setup>


</script>

<style lang="css" scoped>
NuxtLinkText{
    text-decoration: none;
}
.navText{
    text-decoration:none;
    transition: color .2s;

    border-width: 1px;
    display:flex;
    width: 60px;
    height: 23px;
    background-color: #ced9ff;
    transition:
        width 2s,
        height 2s,
        background-color 2s,
        transform 2s;
}

.navText:hover{
    font-size: 20px;
    background-color: #ffcccc;
    width: 80px;
    height: 40px;
}
#icon{
    fill:rgb(107, 107, 107) ;
    width:30px;
    height: 30px;
}
</style>