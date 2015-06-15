# Docker image of R Shiny Server with Chinese Support

The shiny-server image provided by [rocker/shiny](https://registry.hub.docker.com/u/rocker/shiny/) does not render chinese characters in the graphics correctly.

Intead, this repository correctly display the chinese characters due to setting the LANG and LOCALE during installation of required packages.

Please check the page wiki page of [rocker/shiny](https://registry.hub.docker.com/u/rocker/shiny/) for using the repository.
