# Use an official Python 3.10 slim runtime as a parent image
FROM python:3.10-slim

# Set environment variables for non-interactive installations and Spark/Java
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Install system dependencies (Java 21 OpenJDK is required for Spark 4.1+)
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-21-jre-headless \
    build-essential \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
# We create a requirements.txt file in the build stage, but let's install directly via pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    pyspark==4.1.2 \
    xgboost \
    pandas \
    scikit-learn \
    matplotlib \
    seaborn \
    jupyter \
    ipykernel

# Copy the rest of the application code into the container at /app
# (Large datasets like traffic_sensor_data.csv should be mounted via volumes or downloaded)
COPY . /app

# Expose port 8888 for the Jupyter Notebook server
EXPOSE 8888

# Create a non-root user for security and set permissions
RUN useradd -m sparkuser && chown -R sparkuser:sparkuser /app
USER sparkuser

# Start the Jupyter Notebook server by default
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
