<template>
    <div>
      <div class="p-5">
        <div class="container">
          <div class="box">
            <h3>date</h3>
            <input type="text" class="datepicker-here form-control" id="minMaxExample" data-date-format="dd/mm/yyyy" data-language='en' placeholder="seléctionner une date">
			<DatePicker/>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">

const date = ref(new Date())
</script>




<style lang="scss" scoped>

.container{
	max-width: 600px;
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