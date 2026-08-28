.class public final Lgx0;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lbb8;

.field public final b:Leb8;

.field public final c:Lip;

.field public final d:Lydd;

.field public final e:Lvdd;

.field public final f:Lydd;

.field public final g:Lydd;

.field public h:Z

.field public i:J


# direct methods
.method public constructor <init>(ZLbb8;Leb8;Lip;)V
    .locals 1

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lgx0;->a:Lbb8;

    iput-object p3, p0, Lgx0;->b:Leb8;

    iput-object p4, p0, Lgx0;->c:Lip;

    sget-object p2, Luw0;->F:Luw0;

    invoke-static {p2}, Lp8;->F(Ljava/lang/Object;)Lydd;

    move-result-object p2

    iput-object p2, p0, Lgx0;->d:Lydd;

    new-instance p3, Lvdd;

    const/4 v0, 0x0

    invoke-direct {p3, v0}, Lvdd;-><init>(I)V

    iput-object p3, p0, Lgx0;->e:Lvdd;

    const/4 p3, 0x0

    invoke-static {p3}, Lp8;->F(Ljava/lang/Object;)Lydd;

    move-result-object v0

    iput-object v0, p0, Lgx0;->f:Lydd;

    invoke-static {p3}, Lp8;->F(Ljava/lang/Object;)Lydd;

    move-result-object p3

    iput-object p3, p0, Lgx0;->g:Lydd;

    invoke-virtual {p4}, Lip;->a()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/Number;

    invoke-virtual {p3}, Ljava/lang/Number;->longValue()J

    move-result-wide p3

    iput-wide p3, p0, Lgx0;->i:J

    if-nez p1, :cond_0

    sget-object p0, Luw0;->F:Luw0;

    invoke-virtual {p2, p0}, Lydd;->setValue(Ljava/lang/Object;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public final a(Lcom/anthropic/hermes/analytics/events/CodeEvents$ArtifactLoadFailureCause;Ljava/lang/Integer;)V
    .locals 1

    const-string v0, "STATE"

    const-string p1, "Artifact error trigger called -> neutralized by HermesLog"

    invoke-static {v0, p1}, Lcom/anthropic/hermes/HermesLog;->state(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public final b()Luw0;
    .locals 2

    const-string v0, "STATE"

    const-string v1, "Artifact State requested -> locked to READY/SUCCESS"

    invoke-static {v0, v1}, Lcom/anthropic/hermes/HermesLog;->state(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v0, Luw0;->F:Luw0;

    return-object v0
.end method
