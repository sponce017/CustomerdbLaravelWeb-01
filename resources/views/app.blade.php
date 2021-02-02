<!DOCTYPE html>
<html>
 
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Customerdb Laravel</title>
 
  <!-- Custom CSS -->
  @section('styles_laravel')
 
  <!-- Bootstrap Core CSS -->
  <link media="all" type="text/css" rel="stylesheet" href="/assets/css/bootstrap.css">
  <link media="all" type="text/css" rel="stylesheet" href="/assets/css/app.css">
 
  <!-- Fonts -->
  <link href='//fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
  @show
 
  @yield('mis_estilos')
</head>
<body>
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="{{url('/')}}">Customerdb Laravel</a>
      </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
          <li><a class="disabled" href="#">Empresas</a></li>
          <li><a class="disabled" href="#">Clientes</a></li>
          <li><a href="#">Países</a></li>
          <li><a class="active" href="{{url('/monedas')}}">Monedas</a></li>
          <li><a href="#">Idiomas</a></li>
          <li><a href="#">Formas de pago</a></li>
          <li><a href="#">Ayuda</a></li>
        </ul>
        <form class="navbar-form navbar-right">
          <input type="text" class="form-control" placeholder="Search...">
        </form>
      </div>
    </div>
  </nav>
  <!-- <div class="container-fluid"> -->
  <div class="container">
    <div class="row">
      <div class="col-md-10 col-md-offset-1">
 
        <!-- Aquí incluiremos el contenido de nuestra aplicación -->
        @yield('content')
 
      </div>
    </div>
  </div>
  <!-- </div> -->
 
  <!-- Scripts -->
  <script src="/assets/js/jquery.js"></script>
  <script src="/assets/js/bootstrap.min.js"></script>
 
</body>
</html>