.class public final Lxn6;
.super Ltac;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ltac;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001\u00a8\u0006\u0003"
    }
    d2 = {
        "Lxn6;",
        "Ltac;",
        "Lfo6;",
        "foundation"
    }
    k = 0x1
    mv = {
        0x2,
        0x1,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final M:Ljl3;


# instance fields
.field public final E:Lgo6;

.field public final F:Lh6d;

.field public final G:Z

.field public final H:Lifc;

.field public final I:Z

.field public final J:Ldb8;

.field public final K:Ldb8;

.field public final L:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljl3;

    const/16 v1, 0x1b

    invoke-direct {v0, v1}, Ljl3;-><init>(I)V

    sput-object v0, Lxn6;->M:Ljl3;

    return-void
.end method

.method public constructor <init>(Lgo6;Lh6d;ZLifc;ZLdb8;Ldb8;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lxn6;->E:Lgo6;

    iput-object p2, p0, Lxn6;->F:Lh6d;

    iput-boolean p3, p0, Lxn6;->G:Z

    iput-object p4, p0, Lxn6;->H:Lifc;

    iput-boolean p5, p0, Lxn6;->I:Z

    iput-object p6, p0, Lxn6;->J:Ldb8;

    iput-object p7, p0, Lxn6;->K:Ldb8;

    iput-boolean p8, p0, Lxn6;->L:Z

    return-void
.end method


# virtual methods
.method public final create()Lnac;
    .locals 5

    new-instance v0, Lfo6;

    sget-object v1, Lxn6;->M:Ljl3;

    iget-boolean v2, p0, Lxn6;->G:Z

    iget-object v3, p0, Lxn6;->H:Lifc;

    iget-object v4, p0, Lxn6;->F:Lh6d;

    invoke-direct {v0, v1, v2, v3, v4}, Ljn6;-><init>(Lna8;ZLifc;Lh6d;)V

    iget-object v1, p0, Lxn6;->E:Lgo6;

    iput-object v1, v0, Lfo6;->n0:Lgo6;

    iput-object v4, v0, Lfo6;->o0:Lh6d;

    iget-boolean v1, p0, Lxn6;->I:Z

    iput-boolean v1, v0, Lfo6;->p0:Z

    iget-object v1, p0, Lxn6;->J:Ldb8;

    iput-object v1, v0, Lfo6;->q0:Ldb8;

    iget-object v1, p0, Lxn6;->K:Ldb8;

    iput-object v1, v0, Lfo6;->r0:Ldb8;

    iget-boolean p0, p0, Lxn6;->L:Z

    iput-boolean p0, v0, Lfo6;->s0:Z

    return-object v0
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    :cond_1
    const-class v2, Lxn6;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_2

    return v1

    :cond_2
    check-cast p1, Lxn6;

    iget-object v2, p0, Lxn6;->E:Lgo6;

    iget-object v3, p1, Lxn6;->E:Lgo6;

    invoke-static {v2, v3}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    return v1

    :cond_3
    iget-object v2, p0, Lxn6;->F:Lh6d;

    iget-object v3, p1, Lxn6;->F:Lh6d;

    if-eq v2, v3, :cond_4

    return v1

    :cond_4
    iget-boolean v2, p0, Lxn6;->G:Z

    iget-boolean v3, p1, Lxn6;->G:Z

    if-eq v2, v3, :cond_5

    return v1

    :cond_5
    iget-object v2, p0, Lxn6;->H:Lifc;

    iget-object v3, p1, Lxn6;->H:Lifc;

    invoke-static {v2, v3}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    return v1

    :cond_6
    iget-boolean v2, p0, Lxn6;->I:Z

    iget-boolean v3, p1, Lxn6;->I:Z

    if-eq v2, v3, :cond_7

    return v1

    :cond_7
    iget-object v2, p0, Lxn6;->J:Ldb8;

    iget-object v3, p1, Lxn6;->J:Ldb8;

    invoke-static {v2, v3}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    return v1

    :cond_8
    iget-object v2, p0, Lxn6;->K:Ldb8;

    iget-object v3, p1, Lxn6;->K:Ldb8;

    invoke-static {v2, v3}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_9

    return v1

    :cond_9
    iget-boolean p0, p0, Lxn6;->L:Z

    iget-boolean p1, p1, Lxn6;->L:Z

    if-eq p0, p1, :cond_a

    return v1

    :cond_a
    return v0
.end method

.method public final hashCode()I
    .locals 3

    iget-object v0, p0, Lxn6;->E:Lgo6;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    const/16 v1, 0x1f

    mul-int/2addr v0, v1

    iget-object v2, p0, Lxn6;->F:Lh6d;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v2, v0

    mul-int/2addr v2, v1

    iget-boolean v0, p0, Lxn6;->G:Z

    invoke-static {v2, v1, v0}, Lqyi;->p(IIZ)I

    move-result v0

    iget-object v2, p0, Lxn6;->H:Lifc;

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    add-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-boolean v2, p0, Lxn6;->I:Z

    invoke-static {v0, v1, v2}, Lqyi;->p(IIZ)I

    move-result v0

    iget-object v2, p0, Lxn6;->J:Ldb8;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    add-int/2addr v2, v0

    mul-int/2addr v2, v1

    iget-object v0, p0, Lxn6;->K:Ldb8;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    add-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-boolean p0, p0, Lxn6;->L:Z

    invoke-static {p0}, Ljava/lang/Boolean;->hashCode(Z)I

    move-result p0

    add-int/2addr p0, v0

    return p0
.end method

.method public final update(Lnac;)V
    .locals 6

    move-object v0, p1

    check-cast v0, Lfo6;

    iget-object p1, v0, Lfo6;->n0:Lgo6;

    iget-object v1, p0, Lxn6;->E:Lgo6;

    invoke-static {p1, v1}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    const/4 v2, 0x1

    if-nez p1, :cond_0

    iput-object v1, v0, Lfo6;->n0:Lgo6;

    move p1, v2

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iget-object v1, v0, Lfo6;->o0:Lh6d;

    iget-object v4, p0, Lxn6;->F:Lh6d;

    if-eq v1, v4, :cond_1

    iput-object v4, v0, Lfo6;->o0:Lh6d;

    move p1, v2

    :cond_1
    iget-boolean v1, v0, Lfo6;->s0:Z

    iget-boolean v3, p0, Lxn6;->L:Z

    if-eq v1, v3, :cond_2

    iput-boolean v3, v0, Lfo6;->s0:Z

    move v5, v2

    goto :goto_1

    :cond_2
    move v5, p1

    :goto_1
    iget-object p1, p0, Lxn6;->J:Ldb8;

    iput-object p1, v0, Lfo6;->q0:Ldb8;

    iget-object p1, p0, Lxn6;->K:Ldb8;

    iput-object p1, v0, Lfo6;->r0:Ldb8;

    iget-boolean p1, p0, Lxn6;->I:Z

    iput-boolean p1, v0, Lfo6;->p0:Z

    sget-object v1, Lxn6;->M:Ljl3;

    iget-boolean v2, p0, Lxn6;->G:Z

    iget-object v3, p0, Lxn6;->H:Lifc;

    invoke-virtual/range {v0 .. v5}, Ljn6;->J1(Lna8;ZLifc;Lh6d;Z)V

    return-void
.end method
