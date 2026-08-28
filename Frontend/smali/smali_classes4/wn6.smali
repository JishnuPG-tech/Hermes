.class public final Lwn6;
.super Lnac;
.source "SourceFile"

# interfaces
.implements Lh9a;


# instance fields
.field public S:Lp57;

.field public T:Lbb8;

.field public U:Lh6d;

.field public V:Z


# virtual methods
.method public final b(Lwnb;Lnnb;J)Lvnb;
    .locals 10

    invoke-interface {p2, p3, p4}, Lnnb;->r(J)Lgpd;

    move-result-object p2

    invoke-interface {p1}, Lip9;->m0()Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lwn6;->V:Z

    if-nez v0, :cond_3

    :cond_0
    iget v0, p2, Lgpd;->E:I

    iget v3, p2, Lgpd;->F:I

    int-to-long v4, v0

    const/16 v0, 0x20

    shl-long/2addr v4, v0

    int-to-long v6, v3

    const-wide v8, 0xffffffffL

    and-long/2addr v6, v8

    or-long v3, v4, v6

    iget-object v0, p0, Lwn6;->T:Lbb8;

    new-instance v5, Lql9;

    invoke-direct {v5, v3, v4}, Lql9;-><init>(J)V

    new-instance v3, Lm45;

    invoke-direct {v3, p3, p4}, Lm45;-><init>(J)V

    invoke-interface {v0, v5, v3}, Lbb8;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Load;

    iget-object p4, p3, Load;->E:Ljava/lang/Object;

    check-cast p4, Lg06;

    iget-object p3, p3, Load;->F:Ljava/lang/Object;

    invoke-virtual {p4, p3}, Lg06;->c(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p4, Lg06;->a:Ljava/util/List;

    invoke-static {v2, v0}, Lun4;->x0(ILjava/util/List;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    goto :goto_0

    :cond_2
    move-object p3, v0

    :goto_0
    iget-object v0, p0, Lwn6;->S:Lp57;

    iget-object v0, v0, Lp57;->F:Ljava/lang/Object;

    check-cast v0, Lsz;

    invoke-virtual {v0, p4, p3}, Lsz;->h(Lg06;Ljava/lang/Object;)V

    iput-boolean v1, p0, Lwn6;->V:Z

    :cond_3
    invoke-interface {p1}, Lip9;->m0()Z

    move-result p3

    if-nez p3, :cond_5

    iget-boolean p3, p0, Lwn6;->V:Z

    if-eqz p3, :cond_4

    goto :goto_1

    :cond_4
    move v1, v2

    :cond_5
    :goto_1
    iput-boolean v1, p0, Lwn6;->V:Z

    iget p3, p2, Lgpd;->E:I

    iget p4, p2, Lgpd;->F:I

    new-instance v0, Ldl4;

    const/16 v1, 0xb

    invoke-direct {v0, v1, p1, p0, p2}, Ldl4;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    sget-object p0, Lkx6;->E:Lkx6;

    invoke-interface {p1, p3, p4, p0, v0}, Lwnb;->V(IILjava/util/Map;Lna8;)Lvnb;

    move-result-object p0

    return-object p0
.end method

.method public final i1()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lwn6;->V:Z

    return-void
.end method
