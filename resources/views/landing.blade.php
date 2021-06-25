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
        
        <!--REVISAR SI LA TIENDA ESTÁ ACTIVA O NO-->
        @if ($offices[0]->disabled == '0')
                <div class="row" id="available">
                    <p>Hola! En este momento <span style="color: red;"> no estamos disponibles.</span>
                        Pero te invitamos a conocer nuestro catalogo!
                    </p>
                </div>
        @endif
    </div>
    <div class="row d-none d-md-block"> <!-- desktop -->
        @include('landing.desktop.portada')
        @include('landing.desktop.deliveries')
        @include('landing.desktop.carta')
        <!--@include('landing.desktop.nav')-->
        
        <!--REVISAR SI LA TIENDA ESTÁ ACTIVA O NO-->
        @if ($offices[0]->disabled == '0')
                <div class="row" id="available">
                    <p>Hola! En este momento <span style="color: red;"> no estamos disponibles.</span>
                        Pero te invitamos a conocer nuestro catalogo!
                    </p>
                </div>
        @endif
    </div>
    </body>
</html>
