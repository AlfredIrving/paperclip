FROM ghcr.io/paperclipai/paperclip:v2026.416.0

# Patch: embed paperclip context inside message field instead of top-level property
# Fixes: "invalid agent params: at root: unexpected property 'paperclip'"
COPY packages/adapters/openclaw-gateway/dist/server/execute.js /app/packages/adapters/openclaw-gateway/dist/server/execute.js
