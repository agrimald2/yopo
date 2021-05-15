<!DOCTYPE html>
<html lang="es">
    <head>
        @include('landing.head')
    </head>
    <body>
    <div class="row d-sm-block d-md-none"> <!-- celular -->
        @include('landing.portada')
        @include('landing.deliveries')
        @include('landing.carta')
        @include('landing.nav')
    </div>
    <div class="row d-none d-md-block"> <!-- desktop -->
        <h1>Desktop</h1>
    </div>
    </body>
</html>
