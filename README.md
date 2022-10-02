
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CityShadeMap

<!-- badges: start -->

[![R-CMD-check](https://github.com/Pakillo/CityShadeMap/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Pakillo/CityShadeMap/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Idea inicial: básicamente empezar por fabricar un **mapa de
sombras/insolación horario para todo el año de alta resolución**
teniendo en cuenta el relieve de edificios y tal vez árboles. Para ello
podría usarse datos lidar (del PNOA o de la
[REDIAM](https://www.juntadeandalucia.es/medioambiente/portal/landing-page-%C3%ADndice/-/asset_publisher/zX2ouZa4r1Rf/content/cobertura-lidar/20151)),
o probar los datos de edificios que tiene OpenStreetMap
(<https://osmbuildings.org/?lat=37.38863&lon=-5.99534&zoom=16.0&tilt=30>).

Hay aplicaciones parecidas, p ej

<https://shademap.app/@40.4163,-3.6934,10z,1643369189777t,0b,0p>

<https://shadowmap.org/>

<https://www.huellasolar.com/>

Pero nada Open Source que yo conozca. La idea es generar a la vez (1) un
paquete de R open source para que cualquiera pueda analizar su ciudad y
(2) un análisis detallado de la ciudad de Sevilla.

Una vez tengamos el mapa de sombras/insolación de detalle se pueden
hacer muchas cosas, p ej

-   Analizar, calle a calle o barrio a barrio, las zonas más expuestas
    al sol en verano, o menos en invierno

-   Analizar dónde el arbolado está o podría amortiguar más el exceso de
    calor (incluso a nivel de especie, tipo de hoja etc, ya que existe
    un mapa detallado del arbolado:
    <https://www.arbomap.com/arbomapciudadano/accesos/sevilla/>)

-   Relacionarlo con medidas de temperatura de Landsat

-   Diseñar rutas de sombra para ir de un sitio a otro

etc

## Papers relacionados

<https://doi.org/10.3390/rs11202348>

<https://doi.org/10.1016/j.scs.2019.101931>

<https://www.sciencedirect.com/science/article/abs/pii/S0169204617301950>

<https://doi.org/10.1016/j.ufug.2018.02.013>

<https://doi.org/10.1016/j.jag.2020.102161>

<https://doi.org/10.1016/j.compenvurbsys.2021.101655>
