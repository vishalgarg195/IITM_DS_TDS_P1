# Base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Prevent Python from writing pyc files and enable unbuffered stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y git curl build-essential && rm -rf /var/lib/apt/lists/*

# Copy requirements file (if you have one) or install packages directly
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Install aipipe from GitHub (latest)
RUN pip install --no-cache-dir git+https://github.com/x-zx/aipipe.git

# Copy the app code
COPY . .

# Expose port
EXPOSE 7860

# Entrypoint
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]
