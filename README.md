# InstaCanvas

Flutter app to fetch and save Instagram profile pictures (HD) by username.

## Profile-picture fetching

Fetching uses a two-tier strategy (see [`lib/api_service.dart`](lib/api_service.dart)):

1. **Direct** — calls Instagram's public `web_profile_info` endpoint. Free, no
   key, and works from real end-user devices on residential/mobile IPs.
2. **Apify fallback** — if the direct call fails (Instagram rate-limit or
   login wall, common on datacenter / flagged IPs), it falls back to Apify's
   **Instagram Profile Scraper** actor, which handles auth + residential
   proxies server-side and works from any IP.

> Note: Instagram blocks unauthenticated scraping from datacenter/flagged IPs
> (returns HTTP 429 / `require_login`). The direct path still works for real
> users on mobile/residential IPs; the Apify fallback covers the rest.

### Enable the Apify fallback (one-time, free — no credit card)

1. Create a free account at <https://apify.com> ($5/month credit ≈ ~2,000
   profiles/month, no card required).
2. **Settings → API & Integrations** → copy your Personal API token
   (starts with `apify_api_...`).
3. Run the app with it injected (never hardcode):

   ```bash
   flutter run --dart-define=APIFY_TOKEN=apify_api_xxx
   # release build:
   flutter build apk --dart-define=APIFY_TOKEN=apify_api_xxx
   ```

If no token is provided, the app uses the direct path only.

## Run

```bash
flutter pub get
flutter run
```
