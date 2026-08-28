.class public final Lcn6;
.super Lg85;
.source "SourceFile"


# instance fields
.field public E:Ljava/lang/Object;

.field public F:Ljava/lang/Object;

.field public G:Lcb8;

.field public H:Ljava/lang/Object;

.field public I:Ljava/lang/Object;

.field public J:Ljava/lang/Object;

.field public K:Ljava/lang/Object;

.field public L:Ljava/lang/Object;

.field public M:Ljava/lang/Object;

.field public N:Lg0f;

.field public O:Lgu8;

.field public P:Lfud;

.field public Q:Z

.field public R:F

.field public synthetic S:Ljava/lang/Object;

.field public T:I


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    iput-object p1, p0, Lcn6;->S:Ljava/lang/Object;

    iget p1, p0, Lcn6;->T:I

    const/high16 v0, -0x80000000

    or-int/2addr p1, v0

    iput p1, p0, Lcn6;->T:I

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v7, p0

    invoke-static/range {v0 .. v7}, Ldn6;->i(Llzh;Lfud;Lh76;Lzo;Lbb8;Lla8;Lrz0;Lti1;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
