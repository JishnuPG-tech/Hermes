.class public final Lkx0;
.super Lb7;
.source "SourceFile"


# instance fields
.field public final f:Lcu0;

.field public final g:Lnp;

.field public final h:Lbc;

.field public final i:Lip;

.field public final j:Lip;

.field public final k:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Lixf;Lcu0;Lnp;Lbc;Lip;Lip;)V
    .locals 0

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {p0, p1}, Lb7;-><init>(Lixf;)V

    iput-object p2, p0, Lkx0;->f:Lcu0;

    iput-object p3, p0, Lkx0;->g:Lnp;

    iput-object p4, p0, Lkx0;->h:Lbc;

    iput-object p5, p0, Lkx0;->i:Lip;

    iput-object p6, p0, Lkx0;->j:Lip;

    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lkx0;->k:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method public final c(Landroid/net/Uri;)Z
    .locals 0

    const/4 p0, 0x1

    return p0
.end method

.method public final onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Lix0;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1}, Lix0;-><init>(Lkx0;I)V

    iget-object v1, p0, Lkx0;->k:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    return-void
.end method

.method public final onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 1

    if-eqz p2, :cond_0

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    const-string p1, "ON_RECEIVED_ERROR"

    invoke-static {p1, v0}, Lcom/anthropic/hermes/HermesLog;->wv(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .locals 1

    if-eqz p2, :cond_0

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    const-string p1, "ON_RECEIVED_HTTP_ERROR"

    invoke-static {p1, v0}, Lcom/anthropic/hermes/HermesLog;->wv(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .locals 2

    if-eqz p2, :cond_0

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "INTERCEPT_REQUEST"

    invoke-static {v1, v0}, Lcom/anthropic/hermes/HermesLog;->wv(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    invoke-super {p0, p1, p2}, Lb7;->shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;

    move-result-object p0

    return-object p0
.end method

.method public final shouldOverrideUrlLoading(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Z
    .locals 2

    if-eqz p2, :cond_1

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->isForMainFrame()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v0, p0, Lkx0;->f:Lcu0;

    invoke-static {p1, v0}, Lcx0;->c(Landroid/net/Uri;Lcu0;)Z

    move-result p1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    return v1

    :cond_0
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {p1, v0}, Lcx0;->d(Landroid/net/Uri;Lcu0;)Z

    move-result p1

    new-instance p2, Ljx0;

    invoke-direct {p2, p0, p1, v1}, Ljx0;-><init>(Ljava/lang/Object;ZI)V

    iget-object p0, p0, Lkx0;->k:Landroid/os/Handler;

    invoke-virtual {p0, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    const/4 p0, 0x1

    return p0
.end method
