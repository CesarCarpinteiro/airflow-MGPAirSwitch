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

    # Allow 'airflow' user to access Docker
#RUN usermod -aG docker airflow
    
    # Switch back to Airflow user
USER airflow
    
    # Upgrade pip
RUN python -m pip install --no-cache-dir --upgrade pip
    
    # Copy the requirements file
COPY requirements.txt /requirements.txt
    
    # Install Python dependencies
RUN pip install --no-cache-dir -r /requirements.txt
