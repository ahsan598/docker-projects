# Base Image
FROM drupal:10-apache

# Install Git (to clone the theme)
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Set working directory for themes
WORKDIR /var/www/html/themes

# Clone the official Bootstrap theme
RUN git clone --branch 8.x-4.x --single-branch --depth 1 \
    https://git.drupalcode.org/project/bootstrap.git

# Fix permissions for web user
RUN chown -R www-data:www-data bootstrap

# Reset to Drupal root directory
WORKDIR /var/www/html
