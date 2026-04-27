# Fix Status: Paperclip OpenClaw Adapter — Issue #617

## Problem
OpenClaw gateway rejects unknown top-level properties in agent params. The `paperclip` key was being sent as a top-level property, causing:
```
invalid agent params: at root: unexpected property 'paperclip'
```

## Fix Applied
**Commit:** `4275476` on branch `fix/openclaw-paperclip-adapter`

**Changes:**
1. `packages/adapters/openclaw-gateway/src/server/execute.ts` (lines 1136-1143)
   - Removed: `agentParams.paperclip = paperclipPayload`
   - Added: Embed paperclip context as HTML comment block inside `message` field
   - Result: OpenClaw strict validation passes, agent still receives full context

2. `Dockerfile`
   - Removed: `VOLUME /paperclip` directive
   - Reason: Railway compatibility (Railway doesn't support VOLUME directives well)

## PR Status
- **PR #4355** opened: https://github.com/paperclipai/paperclip/pull/4355
- Links to: Issue #617
- Base: `master`, Head: `AlfredIrving:fix/openclaw-paperclip-adapter`

## Deployment Blockers
| Blocker | Status | Resolution Path |
|---------|--------|---------------|
| Railway trial expired | 🔴 Blocking | Upgrade Railway plan or wait for upstream merge |
| No local Docker | 🔴 Blocking | Can't build/push image manually |
| Upstream GHCR image | ⏳ Waiting | Auto-builds on merge to `master` via `docker.yml` workflow |

## Options to Proceed

### Option 1: Wait for Upstream Merge (Free)
- Once PR #4355 merges, GitHub Actions `docker.yml` auto-builds and pushes `ghcr.io/paperclipai/paperclip:latest`
- Then: Update Railway service image reference to new build
- ETA: Depends on maintainer review velocity

### Option 2: Build on Fork's GitHub Actions (Free)
- Enable Actions on `AlfredIrving/paperclip` fork
- Push `fix/openclaw-paperclip-adapter` to fork's `master` to trigger `docker.yml`
- Builds `ghcr.io/alfredirving/paperclip:latest`
- Update Railway service to use fork's GHCR image
- Requires: Fork Actions enabled, `GITHUB_TOKEN` has `packages:write`

### Option 3: Upgrade Railway ($5-9/mo)
- Immediate deployment via `railway up`
- Builds from local Dockerfile with fix applied
- Fastest path if budget allows

### Option 4: Build Docker Elsewhere
- Use cloud VM, GitHub Codespaces, or friend's machine with Docker
- Build image, push to GHCR or Docker Hub
- Update Railway service reference

## Recommended Action
**Short-term:** Enable GitHub Actions on fork (Option 2). Push branch to fork's `master` to trigger Docker build. This gives us a working GHCR image today without spending money or waiting for upstream review.

**Long-term:** Upstream merge (Option 1) is the cleanest path — no fork maintenance needed.
