<template>
    <div>
        <nav class="navbar navbar-expand-lg fond shadow-sm">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse " id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 couleurTexte">
                        <li class="nav-item">
                            <a class="nav-link couleurTexte" :class="{ navText: isActive === 'upload' }"href="/" aria-current="page" @click="isActive = 'upload'">téléchargement</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link couleurTexte" :class="{ navText: isActive === 'affichage' }" href="/depotfichier" @click="isActive = 'affichage'">envoi</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link couleurTexte" :class="{ navText: isActive === 'affichage' }" href="/paiement" @click="isActive = 'paiement'">paiement</a>
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
    name:'AppHeader',
    data() {
        return {
            isActive: ''
        }
    }
}
</script>

<style lang="css" scoped>
.tailleIcone {
    height: 16px;
    width: 16px;
}
.navText {
    text-decoration: none;
    border-width: 1px;
    border-radius: 30px;
    display: flex;
    background-color: #000000;
}
.navText:hover {
    background-color: #ffffff;
    border-radius: 50px;
}
.fond {
    background-color: #ddd0c8;
}
.couleurTexte {
    color: white;
}
.couleurTexte:hover{
    color: #000000;
}
#icon {
    fill: rgb(107, 107, 107);
    width: 30px;
    height: 30px;
}
</style>