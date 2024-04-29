<template>
    <div>
      <div class="p-5">
        <div class="container">
          <div class="box d-flex">
			      <input type="search" class="form-control " value="Nom du fichier">
			      <input type="date" class="form-control" name="ad" id="">
            <select class="form-select" aria-label="Default select example">
            <option selected>category</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
            </select>
            <input type="submit" class="form-control" value="rechercher">
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
</script>




<style lang="scss" scoped>

.container{
	
}
.box{
	padding: 50px;
	background: #ffffff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
    transform: translateY(-10px);
    box-shadow: 0px 20px 40px rgba(0, 0, 0, 0.35);
}

.box h3{
	text-align: center;
	padding: 0 0 30px 0;
}
.box .form-control{
	max-width: 300px;
	margin: 0 auto;	
}
.datepicker{
	font-family: 'Exo 2', sans-serif;
}
.datepicker--cell.-range-to-{
	background: rgba(248, 206, 236, 0.4);
	border-color: rgba(248, 206, 236, 1);
}
.datepicker--cell.-current-{}
.datepicker--cell.-selected-,.datepicker--cell.-selected-.-focus-{
	background-color: #f8ceec;
	color: #000000;
}
.datepicker--cell.-in-range-{
	background: rgba(248, 206, 236, 0.2);
}
.datepicker--cell-day {
    font-weight: 500;
    color: #000000;
}

.form-control{
	height: 50px;
	font-size: 16px;
	color: #414D64;
	background: #ffffff;
	padding: 0 15px;
	border: 2px solid #DADEEA;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition: all 0.3s ease-in-out;
	-o-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
	text-align: center;
}
textarea.form-control{
	height: 120px;
	padding-top: 15px;
}
.form-control-plaintext{
	font-size: 18px;
	color: #434343;
}
button.form-control{
	text-overflow: ellipsis;
	overflow: hidden;
}
.form-control:focus{
	border-color: #ffafd0;
	-webkit-box-shadow: 0px 2px 6px rgba(55, 180, 72, .15);
	-moz-box-shadow: 0px 2px 6px rgba(55, 180, 72, .15);
	box-shadow: 0px 2px 6px rgba(55, 180, 72, .15);
}
</style>