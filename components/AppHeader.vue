<template>
    <div>
        <nav class="navbar navbar-expand-lg fond">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse " id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 couleurTexte">
                        <li class="nav-item">
                            <a class="nav-link  couleurTexte" href="#" aria-current="page">upload</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link couleurTexte navText" href="#">affichage</a>
                        </li>
                        <li class="nav-item dropdown">
                        </li>
                    </ul>
                    <i class="bi bi-person tailleIcone couleurTexte"></i>
                </div>
            </div>
        </nav>
    </div>
</template>

<script>
export default {
    name:'AppHeader'
}
</script>

<style lang="css" scoped>

</style>