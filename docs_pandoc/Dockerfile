
ARG TAG="3.2-ubuntu"
FROM pandoc/extra:${TAG}

RUN apt update && apt dist-upgrade -y

# wkhtmltopdf install dependencies
RUN apt install -y \
    wkhtmltopdf \
    xvfb \
    libxrender1 \
    libfontconfig1 \
    libx11-dev \
    libjpeg62 \
    libxtst6 \
    xfonts-75dpi \
    xfonts-base

RUN apt-get update && \
    apt-get install -y fonts-dejavu-core fonts-freefont-ttf && \
    rm -rf /var/lib/apt/lists/*

# Update font cache
RUN fc-cache -f -v