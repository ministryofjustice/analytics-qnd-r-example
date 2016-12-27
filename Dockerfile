FROM rocker/shiny:latest

RUN rm -rf /srv/shiny-server/*

COPY drinkr/shiny_app/* /srv/shiny-server/
