FROM ghcr.io/paperclipai/paperclip:sha-b8725c5

# Patch: embed paperclip context inside message field instead of top-level property
# Fixes: "invalid agent params: at root: unexpected property 'paperclip'"
COPY packages/adapters/openclaw-gateway/dist/server/execute.js /app/packages/adapters/openclaw-gateway/dist/server/execute.js
