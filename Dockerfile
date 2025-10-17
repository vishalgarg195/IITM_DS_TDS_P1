FROM python:3.11-slim

# Create same UID (1000) that Spaces uses
RUN useradd -m -u 1000 user

WORKDIR /home/user/app

# Install Python dependencies early for caching
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy rest of app and switch to non-root user
COPY --chown=user . .
USER user

# Environment setup
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Expose Hugging Face app port
EXPOSE 7860

# Run FastAPI app
CMD ["uvicorn", "main_test:app", "--host", "0.0.0.0", "--port", "7860"]
