FROM httpd:2.4-alpine
    
COPY ./website/ /usr/local/apache2/htdocs/

CMD ["httpd-foreground"]
