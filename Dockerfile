# Dockerfile
ARG python_version
ARG codename=jammy

FROM ubuntu:${codename}

# Build arguments
ARG python_version
ARG odoo_version
ARG odoo_org_repo=odoo/odoo

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    ODOO_VERSION=${odoo_version} \
    PYTHONUNBUFFERED=1 \
    ODOO_RC=/etc/odoo/odoo.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python${python_version} \
    python${python_version}-dev \
    python${python_version}-venv \
    python3-pip \
    git \
    wget \
    curl \
    postgresql-client \
    libpq-dev \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libjpeg-dev \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Create odoo user
RUN useradd -m -d /opt/odoo -s /bin/bash odoo

# Create virtualenv
RUN python${python_version} -m venv /opt/odoo/venv

# Set PATH to use virtualenv
ENV PATH="/opt/odoo/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Clone Odoo
WORKDIR /opt/odoo
RUN git clone --depth 1 --branch ${odoo_version} https://github.com/${odoo_org_repo}.git odoo

# ⚠️ MODIFICAR requirements.txt para Python 3.10 compatibility
RUN sed -i 's/gevent==21.8.0/gevent==22.10.2/g' /opt/odoo/odoo/requirements.txt && \
    sed -i 's/greenlet==1.1.2/greenlet==2.0.2/g' /opt/odoo/odoo/requirements.txt

# Install Odoo requirements
RUN pip install -r /opt/odoo/odoo/requirements.txt

# Install Odoo in editable mode
RUN pip install -e /opt/odoo/odoo

# Install additional tools
RUN pip install coverage[toml]

# Create config directory
RUN mkdir -p /etc/odoo

# Create basic Odoo configuration
RUN echo "[options]" > ${ODOO_RC} && \
    echo "addons_path = /opt/odoo/odoo/addons" >> ${ODOO_RC} && \
    echo "data_dir = /opt/odoo/.local/share/Odoo" >> ${ODOO_RC}

# Copy scripts and fix line endings
COPY bin/* /usr/local/bin/
RUN dos2unix /usr/local/bin/* && \
    chmod +x /usr/local/bin/*

# Change ownership to odoo user (IMPORTANTE)
RUN chown -R odoo:odoo /etc/odoo /opt/odoo

# Set working directory
WORKDIR /workspace

# Default environment variables for PostgreSQL
ENV PGHOST=postgres \
    PGUSER=odoo \
    PGPASSWORD=odoo \
    PGDATABASE=odoo \
    ADDONS_DIR=. \
    ADDONS_PATH=/opt/odoo/odoo/addons

USER odoo

CMD ["/bin/bash"]
