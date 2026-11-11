{ pkgs, ... }:
{
  containers.caddy.services.shared-context-mcp = "shared-context-mcp:3721";

  programs.quadlets.quadlets."shared-context-mcp.container" = {
    __options.networkNameAlias = false;
    Container = {
      ContainerName = "shared-context-mcp";
      Image = "ghcr.io/reputable2772/shared-context-mcp:latest";
      Network = "caddy.network";
      PodmanArgs = [ "--init" ];
      Volume = [
        ":/app/data"
      ];

      HealthCmd = ''
        node -e "fetch('http://127.0.0.1:3721/health').then((r)=>{if(!r.ok)process.exit(1)}).catch(()=>process.exit(1))"
      '';
      HealthInterval = "30s";
      HealthTimeout = "5s";
      HealthStartPeriod = "15s";
      HealthRetries = 3;
    };
  };

  programs.quadlets.quadlets."shared-context-mcp-image.build".Build = {
    ImageTag = "ghcr.io/reputable2772/shared-context-mcp:latest";
    PodmanArgs = [
      "--layers"
      "--cache-from=ghcr.io/reputable2772/shared-context-mcp"
      "--cache-to=ghcr.io/reputable2772/shared-context-mcp"
    ];
    File = pkgs.writeText "shared-context-mcp-containerfile" ''
      FROM docker.io/node:20-alpine AS builder
      WORKDIR /app
      RUN apk add --no-cache git
      RUN git clone https://github.com/xfajarr/shared-context-mcp.git /app
      RUN npm ci --omit=dev

      FROM docker.io/node:20-alpine
      WORKDIR /app
      ENV NODE_ENV=production
      COPY --from=builder /app /app
      EXPOSE 3721
      VOLUME ["/app/data"]
      CMD ["node", "server.js"]
    '';
  };
}
