<template>
	<div>
	  <div class="p-5">
		<div class="container">
		  <div class="box d-flex">
			<div class="input-container">
			  <input type="search" class="form-control" value="Nom du fichier">
			  <div class="loader"></div> <!-- Loader pour simuler le chargement -->
			</div>
			<div class="input-container">
			  <input type="date" class="form-control" name="ad" id="">
			  <div class="loader"></div> <!-- Loader pour simuler le chargement -->
			</div>
			<div class="input-container">
			  <select class="form-select" aria-label="Default select example">
				<option selected>category</option>
				<option value="1">One</option>
				<option value="2">Two</option>
				<option value="3">Three</option>
							  <div class="loader"></div> <!-- Loader pour simuler le chargement -->

			  </select>
			  <div class="loader"></div> <!-- Loader pour simuler le chargement -->
			</div>
			<div class="input-container">
			  <input type="submit" class="form-control" value="rechercher">
			</div>
		  </div>
		</div>
	  </div>
	</div>
  </template>
  
  <script setup>
  // Aucun script nécessaire pour le moment
  </script>
  
  <style lang="scss" scoped>
  .container {
	// Votre style container
  }
  
  .box {
	// Votre style box
	display: flex;
	align-items: center;
  }
  
  .input-container {
	position: relative;
	margin-right: 20px;
  }
  
  .form-control {
	// Votre style form-control
  }
  
  .loader {
	position: absolute;
	top: 50%;
	right: 10px;
	transform: translateY(-50%);
	border: 2px solid #0000FF;
	border-top: 2px solid transparent;
	border-radius: 50%;
	width: 12px;
	height: 12px;
	animation: spin 1s linear infinite;
	display: none;
  }
  
  @keyframes spin {
	0% { transform: rotate(0deg); }
	100% { transform: rotate(360deg); }
  }
  
  /* Afficher le loader lorsque l'input est en focus */
  .input-container .form-control:focus + .loader {
	display: block;
  }
  </style>
  