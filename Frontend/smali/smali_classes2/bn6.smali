.class public final Lbn6;
.super Lg85;
.source "SourceFile"


# instance fields
.field public E:Llzh;

.field public F:Lna8;

.field public synthetic G:Ljava/lang/Object;

.field public H:I


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iput-object p1, p0, Lbn6;->G:Ljava/lang/Object;

    iget p1, p0, Lbn6;->H:I

    const/high16 v0, -0x80000000

    or-int/2addr p1, v0

    iput p1, p0, Lbn6;->H:I

    const/4 p1, 0x0

    const-wide/16 v0, 0x0

    invoke-static {p1, v0, v1, p1, p0}, Ldn6;->f(Llzh;JLna8;Lti1;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
