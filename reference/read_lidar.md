# Read LiDAR data

Read LiDAR data

## Usage

``` r
read_lidar(folder = NULL, select = "xyz", filter = "-drop_class 7", ...)
```

## Arguments

- folder:

  Character. Path to folder containing las/laz files. Can also be a
  vector of file paths.

- select:

  Character. Point attributes to read from the las/laz files. Use
  `select = "*"` to read all attributes. Default is "xyz" to save
  memory. See
  [`lidR::readLAS()`](https://rdrr.io/pkg/lidR/man/readLAS.html) for
  more details.

- filter:

  Character. Optional. Use if you want to filter out some data points.
  For example, we could filter out noisy data points (class = 7) using
  `filter = "-drop_class 7"`. Use `filter = ""` to read all data points.

- ...:

  Further arguments for
  [`lidR::readLAScatalog()`](https://rdrr.io/pkg/lidR/man/readLAScatalog.html).

## Value

LAScatalog object with LiDAR data

## Examples

``` r
if (FALSE) { # \dontrun{
las <- system.file("extdata", "PlazaNueva.laz", package = "CityShadeMapper")
lidar <- read_lidar(las)
} # }

```
