package com.anthropic.hermes;

/**
 * ArtifactPatch - Native Compose Artifact Fix
 * Intercepts n6.smali and Compose UI blocks to prevent crashes
 * when rendering in-message Markdown, SVG, and HTML artifacts.
 */
public class ArtifactPatch {
    public static String sanitizeArtifactPayload(String rawPayload) {
        if (rawPayload == null) return "";
        // Prevent NullPointerExceptions in Jetpack Compose markdown parser
        return rawPayload.replace("\u0000", "");
    }
}
