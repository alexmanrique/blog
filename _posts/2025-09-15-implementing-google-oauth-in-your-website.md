---
layout: single
title: "Implementing Google OAuth2 in your website"
date: 2025-09-15 09:08:53 +0200
categories: development
comments: true
lang: en
tags: oauth2
image: images/google-oauth2.png
---

{:refdef: style="text-align: center;"}
![AI Database Integration]({{ site.baseurl }}/images/google-oauth2.png)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo generated with ChatGPT
{: refdef}

In this post we’ll see how to integrate Google Sign-In (OAuth 2.0) into your website, from the configuration in Google Cloud to handling the callback in your backend.

## Prerequisites

- Google account
- A web project with a backend (for example, Node/Express, Java/Spring, Python/Flask)
- HTTPS in production (for local development we’ll use `http://localhost`)

## Step 1: Create a project in Google Cloud

1. Go to `https://console.cloud.google.com/`
2. Create a new project or select an existing one
3. Make sure the project is selected in the top bar

## Step 2: Enable Google Identity Services (OAuth 2.0)

1. In the menu, navigate to “APIs & Services” → “Library”
2. Search for “Google Identity Services” (or “OAuth 2.0”) and enable the API

## Step 3: Create OAuth 2.0 credentials

1. Go to “APIs & Services” → “Credentials”
2. Click “Create Credentials” → “OAuth client ID”
3. Choose “Application type: Web application”
4. Give it a descriptive name (e.g., “Web Client - Production”)
5. Configure:
   - Authorized JavaScript origins (frontend):
     - `http://localhost:3000` (development)
     - `https://your-domain.com` (production)
   - Authorized redirect URIs (backend callback):
     - `http://localhost:3000/auth/google/callback`
     - `https://your-domain.com/auth/google/callback`
6. Save and copy the `Client ID` and `Client Secret`

Store them as environment variables in your backend:

```bash
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
GOOGLE_REDIRECT_URI=https://your-domain.com/auth/google/callback
```

In development, use the `localhost` URL for `GOOGLE_REDIRECT_URI`.

## Step 4: Authentication flow

There are two common options:

- Use Google Identity Services (button in the frontend) and send the token to the backend
- Start the flow from the backend by redirecting to Google’s consent screen

Below is a generic example with a backend (Node/Express) initiating the flow:

### 4.1. Redirect to Google

```js
// GET /auth/google
app.get("/auth/google", (req, res) => {
  const params = new URLSearchParams({
    client_id: process.env.GOOGLE_CLIENT_ID,
    redirect_uri: process.env.GOOGLE_REDIRECT_URI,
    response_type: "code",
    scope: "openid email profile",
    access_type: "offline",
    prompt: "consent",
  });
  res.redirect(
    `https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`
  );
});
```

### 4.2. Callback: exchange `code` for tokens

```js
// GET /auth/google/callback
app.get("/auth/google/callback", async (req, res) => {
  const { code } = req.query;
  if (!code) return res.status(400).send("Missing code");

  const tokenResp = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      code,
      client_id: process.env.GOOGLE_CLIENT_ID,
      client_secret: process.env.GOOGLE_CLIENT_SECRET,
      redirect_uri: process.env.GOOGLE_REDIRECT_URI,
      grant_type: "authorization_code",
    }),
  });

  const tokens = await tokenResp.json(); // { id_token, access_token, expires_in, refresh_token? }

  // Validate and decode the ID Token (JWT)
  // You can use google-auth-library or a standard JWT library

  // 1) Verify signature and audience (aud == GOOGLE_CLIENT_ID)
  // 2) Extract claims: sub (userId), email, name, picture

  // Create/sign in your internal user and set cookie/session
  // Then redirect to the frontend
  return res.redirect("/dashboard");
});
```

### 4.3. Alternative: Google Identity Services button (frontend)

If you prefer to manage login from the frontend, integrate the Google Identity Services button and send the `credential` (JWT) to the backend to validate it and create the user session.

Docs: `https://developers.google.com/identity/gsi/web`

## Security and best practices

- Never expose the `Client Secret` in the frontend
- Verify the `id_token` (signature, audience and expiration)
- Use HTTPS in production
- Validate and limit domains in “Authorized origins/redirect URIs”
- Store only the necessary profile data (email, sub) and comply with GDPR/privacy

## Local testing

- Use `http://localhost:3000` as origin and callback
- If your backend runs on another port, adjust the URLs
- Make sure the registered callback exactly matches your route

## Common errors and how to fix them

- `redirect_uri_mismatch`: the callback URL doesn’t match the one registered
- `invalid_client`: check `GOOGLE_CLIENT_ID/SECRET`
- `invalid_grant`: the `code` was already used or the `redirect_uri` doesn’t match
- CORS: correctly add the frontend origin in your backend

## Conclusion

With these steps you’ll have integrated Google Sign-In into your website. Configure origins and callbacks correctly, validate tokens in the backend, and protect the `Client Secret`. Once it’s working, you can link Google identity with your user system and provide a simple and secure login.
