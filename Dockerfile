FROM odoo:17.0

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

USER root

COPY odoo.conf /etc/odoo/

# Download enterprise and 3rdparty addons
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests git

# Install watchdog and XLWT
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        python3-watchdog \
        python3-xlrd \
    && pip3 install xlwt \
    && pip3 install simplejson \
    && rm -rf /var/lib/apt/lists/*

USER odoo

COPY . /mnt/extra-addons

