FROM ubuntu:18.04

# Update the default apache site with the config we created.
COPY config/apache/default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Update php.ini
RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php/7.0/apache2/php.ini
RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php/7.0/cli/php.ini


# Install ProcessWire
RUN git clone git://github.com/processwire/processwire.git -b master ./app
RUN chown -R www-data:www-data ./app

# Expose
#EXPOSE 80

# Volume
VOLUME ["/var/www/pw"]

# Clean
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ./app/.git

# Init
ADD scripts/init.sh /init.sh
RUN chmod +x /init.sh
CMD ["/init.sh"]
