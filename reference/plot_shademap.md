# Plot shade map

Plot shade map

## Usage

``` r
plot_shademap(shade.ras = NULL, legend = TRUE, animate = FALSE, ...)
```

## Arguments

- shade.ras:

  A
  [`terra::SpatRaster()`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
  object with shade intensity, as produced by
  [`make_shademap()`](https://pakillo.github.io/CityShadeMapper/reference/make_shademap.md).

- legend:

  Logical. Show legend?

- animate:

  Logical. Show animation of all the `shade.ras` layers?

- ...:

  Further arguments to
  [`terra::plot()`](https://rspatial.github.io/terra/reference/plot.html),
  or to
  [`terra::animate()`](https://rspatial.github.io/terra/reference/animate.html)
  if `animate` is `TRUE`.

## Value

A static or animated plot.
