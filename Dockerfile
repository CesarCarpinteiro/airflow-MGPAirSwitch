FROM apache/airflow:2.10.3-python3.9

# Switch to root to perform installations
USER root

# Install system dependencies for matplotlib and other Python packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libpng-dev \
    pkg-config \
    libjpeg-dev \
    zlib1g-dev \
    libopenblas-dev \
    liblapack-dev \
    gfortran \
    python3-dev

USER airflow
# Upgrade pip
RUN python -m pip install --no-cache-dir --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt /requirements.txt

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
