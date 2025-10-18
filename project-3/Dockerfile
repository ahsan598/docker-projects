# Base Image
FROM drupal:10-apache-alpine

# Install Git (to clone the theme)
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Clone the official Bootstrap theme
RUN mkdir -p /var/www/html/themes/contrib && \
    git clone --branch 8.x-4.x --single-branch --depth 1 \
    https://git.drupalcode.org/project/bootstrap.git \
    /var/www/html/themes/contrib/bootstrap

# Fix permissions for web user
RUN chown -R www-data:www-data /var/www/html/themes/contrib/bootstrap
