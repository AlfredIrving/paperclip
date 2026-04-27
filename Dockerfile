FROM ghcr.io/paperclipai/paperclip:sha-b8725c5

# Patch the openclaw-gateway adapter source and rebuild
COPY packages/adapters/openclaw-gateway/src/server/execute.ts /app/packages/adapters/openclaw-gateway/src/server/execute.ts

# Rebuild the adapter package
WORKDIR /app/packages/adapters/openclaw-gateway
RUN pnpm run build

WORKDIR /app
