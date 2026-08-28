.class public final Lnn6;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lxwg;

.field public final b:Lxwg;

.field public final c:Lxwg;


# direct methods
.method public constructor <init>(Lxwg;Lxwg;Lxwg;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lnn6;->a:Lxwg;

    iput-object p2, p0, Lnn6;->b:Lxwg;

    iput-object p3, p0, Lnn6;->c:Lxwg;

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_5

    instance-of v2, p1, Lnn6;

    if-nez v2, :cond_1

    goto :goto_0

    :cond_1
    check-cast p1, Lnn6;

    iget-object v2, p1, Lnn6;->a:Lxwg;

    iget-object v3, p0, Lnn6;->a:Lxwg;

    invoke-static {v3, v2}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    return v1

    :cond_2
    iget-object v2, p0, Lnn6;->b:Lxwg;

    iget-object v3, p1, Lnn6;->b:Lxwg;

    invoke-static {v2, v3}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    return v1

    :cond_3
    iget-object p0, p0, Lnn6;->c:Lxwg;

    iget-object p1, p1, Lnn6;->c:Lxwg;

    invoke-static {p0, p1}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_4

    return v1

    :cond_4
    return v0

    :cond_5
    :goto_0
    return v1
.end method

.method public final hashCode()I
    .locals 2

    iget-object v0, p0, Lnn6;->a:Lxwg;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lnn6;->b:Lxwg;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object p0, p0, Lnn6;->c:Lxwg;

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result p0

    add-int/2addr p0, v1

    return p0
.end method
