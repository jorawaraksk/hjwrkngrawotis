FROM python:3.9-slim-bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev ffmpeg mediainfo neofetch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip3 install --no-cache-dir -r requirements.txt flask

# Create secure non-root user (UID 10014)
RUN useradd -u 10014 -m appuser && \
    chown -R 10014:10014 /app

USER 10014

EXPOSE 10000

CMD ["bash", "start.sh"]
