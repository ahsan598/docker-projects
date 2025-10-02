# Official Drupal 10 image as base
FROM drupal:10.2.7-slim

# Install git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Set working directory to themes folder
WORKDIR /var/www/html/themes

# Clone the Bootstrap theme (drupal contrib theme)
RUN git clone --branch 8.x-4.x --single-branch --depth 1 https://git.drupalcode.org/project/bootstrap.git

# Set proper file ownership for Drupal's web server user
RUN chown -R www-data:www-data bootstrap

# Reset working directory back to Drupal's default
WORKDIR /var/www/html
