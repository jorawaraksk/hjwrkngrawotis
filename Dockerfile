FROM python:3.9-slim-bullseye

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev ffmpeg mediainfo neofetch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt flask

# Create non-root user and give permission
RUN useradd -m appuser && chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 10000

# Start bot
CMD ["bash", "start.sh"]
