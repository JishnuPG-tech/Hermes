package com.anthropic.hermes;

/**
 * NetworkRedirector - Reverse-Engineered Endpoint Rewriter
 * Intercepts OkHttp / Cronet request pipelines in the Claude APK
 * to route all API calls to the private Hermes Gateway.
 */
public class NetworkRedirector {
    public static final String ORIGINAL_API_HOST = "api.claude.ai";
    public static final String HERMES_BACKEND_HOST = "jishnupg-hermes.hf.space";
    public static final String HERMES_BACKEND_URL = "https://jishnupg-hermes.hf.space";

    public static String redirectUrl(String originalUrl) {
        if (originalUrl == null) return null;
        if (originalUrl.contains(ORIGINAL_API_HOST)) {
            return originalUrl.replace(ORIGINAL_API_HOST, HERMES_BACKEND_HOST);
        }
        return originalUrl;
    }
}
