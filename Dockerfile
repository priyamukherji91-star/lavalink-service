FROM eclipse-temurin:17-jre

WORKDIR /opt/Lavalink

# --- Lavalink v4 JAR ---
ARG LAVALINK_VERSION=4.0.6
RUN curl -sSL -o Lavalink.jar \
  https://github.com/lavalink-devs/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar

# --- LavaSrc plugin JAR (Spotify support) ---
RUN mkdir -p /plugins
RUN curl -sSL -o /plugins/lavasrc-plugin-4.4.2.jar \
  https://maven.topi.wtf/releases/com/github/topi314/lavasrc/lavasrc-plugin/4.4.2/lavasrc-plugin-4.4.2.jar

# --- Config ---
COPY application.yml ./application.yml

# Railway maps $PORT; we wire it in application.yml
EXPOSE 2333

# Reasonable container JVM defaults
ENV JAVA_TOOL_OPTIONS="-XX:+UseG1GC -XX:MaxRAMPercentage=75"

CMD ["java","-jar","Lavalink.jar"]
