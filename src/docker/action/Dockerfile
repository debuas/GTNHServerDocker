# === Stage 1: Download and Unpack ===
FROM debian:bullseye-slim as download_stage

# Set the working directory to /app
WORKDIR /app

# Install curl and unzip
RUN apt-get update && apt-get install -y curl unzip

# Copy only the script into the container
COPY download_and_unpack.sh .

# Run the download_and_unpack.sh script to fetch and unpack files based on the version argument
ARG DOWNLOAD_URL
ARG FILENAME
#!!Add TOKEN as secret ENV to build 
RUN --mount=type=secret,id=github_token,env=TOKEN \
    chmod +x download_and_unpack.sh && ./download_and_unpack.sh ${FILENAME} ${DOWNLOAD_URL} ${TOKEN}
# === Stage 2: Final Image ===
FROM eclipse-temurin:20

# Set the working directory to /app/server
WORKDIR /app/server

# Copy the files from the download_stage into the final image
COPY --from=download_stage /app/server .

VOLUME /app/server

# Make port 25565 available to the world outside this container
EXPOSE 25565
# Run the correct startup script when the container launches
CMD ["sh", "startserver-java9.sh"]  # Replace with the correct script name
