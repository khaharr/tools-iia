<!-- composant footer des pages  -->
<template>

    <div class="bas"> 
    <div class="pt-5 pb-5 footer">
    <div class="container">
      <div class="row">
        <div class="col-lg-5 col-xs-12 about-company">
          <h2>contact</h2>
          <p class="pr-5 text-white-50">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac ante mollis quam tristique convallis </p>
          <p><NuxtLink to="#"><i class="fa fa-facebook-square mr-1"></i></NuxtLink><NuxtLink to="#"><i class="fa fa-linkedin-square"></i></NuxtLink></p>
        </div>
        <div class="col-lg-3 col-xs-12 links">
          <h4 class="mt-lg-0 mt-sm-3">Lien</h4>
            <ul class="m-0 p-0">
              <li>- <NuxtLink to="#">Lorem ipsum</NuxtLink></li>
              <li>- <NuxtLink to="#">Nam mauris velit</NuxtLink></li>
              <li>- <NuxtLink to="#">Etiam vitae mauris</NuxtLink></li>
              <li>- <NuxtLink to="#">Fusce scelerisque</NuxtLink></li>
              <li>- <NuxtLink to="#">Sed faucibus</NuxtLink></li>
              <li>- <NuxtLink to="#">Mauris efficitur nulla</NuxtLink></li>
            </ul>
        </div>
        <div class="col-lg-4 col-xs-12 location">
          <h4 class="mt-lg-0 mt-sm-4">Localisation</h4>
          <p>22, Lorem ipsum dolor, consectetur adipiscing</p>
          <p class="mb-0"><i class="fa fa-phone mr-3"></i>(541) 754-3010</p>
          <p><i class="fa fa-envelope-o mr-3"></i>DGFIP@gmail.com</p>
        </div>
      </div>
      <div class="row mt-5">
        <div class="col copyright">
          <p class=""><small class="text-white-50">© All Rights Reserved.</small></p>
        </div>
      </div>
    </div>
    </div>
    </div>
    
    
    </template>
    
    <script setup>
    
    
    </script>
    
    <style lang="css" scoped>
    .footer{
      background: #577497;
      color:white;
      
        .links{
        ul {list-style-type: none;}
        li a{
          color: white;
          text-decoration:none;
          transition: color .2s;
            transition-duration: 4s;
            transition-delay: 2s; 
            };
            li a:hover{
            text-decoration:none;
            color:#4180CB;
            font-size: 20px;
        }
        };
        
       
      }  
      .bas{
        bottom:0; 
        width:100%;  
        height:50px;
      }
      .about-company{
        i{font-size: 25px;}
        a{
          color:white;
          transition: color .2s;
          &:hover{color:#4180CB}
        }
      } 
      .location{
        i{font-size: 18px;}
      }
      .copyright p{border-top:1px solid rgba(255,255,255,.1);} 
    
      
    
    
    </style>