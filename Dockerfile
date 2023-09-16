FROM gitpod/workspace-base:latest

COPY --from=composer/composer:2-bin //composer /usr/bin/composer

RUN sudo add-apt-repository ppa:ondrej/php -y && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
    curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash && \
    curl -1sLf 'https://dl.cloudsmith.io/public/friendsofshopware/stable/setup.deb.sh'  | sudo -E bash && \
    sudo apt-get install -y \
        php8.2-fpm \
        php8.2-mysql \ 
        php8.2-curl \
        php8.2-gd \
        php8.2-xml \
        php8.2-zip \
        php8.2-opcache \ 
        php8.2-mbstring \
        php8.2-intl \
        php8.2-cli \
        php8.2-bcmath \
        php8.2-pcov \
        rsync \
        symfony-cli \
        shopware-cli \
        mysql-client-8.0 \
        nodejs && \
    sudo apt-get upgrade -y && \
    echo "memory_limit=512M" > php.ini && \
    echo "assert.active=0" >> php.ini && \
    echo "opcache.interned_strings_buffer=20" >> php.ini && \
    echo "zend.detect_unicode=0" >> php.ini && \
    echo "realpath_cache_ttl=3600" >> php.ini && \
    sudo cp php.ini /etc/php/8.2/cli/conf.d/99-overrides.ini && \
    sudo cp php.ini /etc/php/8.2/fpm/conf.d/99-overrides.ini && \
    rm php.ini && \
    echo "[client]" > ~/.my.cnf && \
    echo "host=127.0.0.1" >> ~/.my.cnf && \
    echo "user=root" >> ~/.my.cnf && \
    echo "password=root" >> ~/.my.cnf && \
    sudo apt-get clean autoclean && \
    sudo apt-get autoremove --yes && \
    sudo rm -rf /var/lib/apt/lists/*
