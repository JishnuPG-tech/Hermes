.class public final Lmn6;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lnnb;

.field public final b:I

.field public c:Z

.field public d:I

.field public e:I

.field public f:Lil9;


# direct methods
.method public constructor <init>(Lnnb;Ll86;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lmn6;->a:Lnnb;

    invoke-interface {p1}, Lnnb;->z()Ljava/lang/Object;

    move-result-object p1

    instance-of v0, p1, Lwbd;

    if-eqz v0, :cond_0

    check-cast p1, Lwbd;

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    if-eqz p1, :cond_1

    iget p1, p1, Lwbd;->e:F

    goto :goto_1

    :cond_1
    const/high16 p1, 0x7fc00000    # Float.NaN

    :goto_1
    invoke-static {p1}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_2

    :cond_2
    const/4 p1, 0x0

    :goto_2
    invoke-interface {p2, p1}, Ll86;->L0(F)I

    move-result p1

    iput p1, p0, Lmn6;->b:I

    const p1, 0x7fffffff

    iput p1, p0, Lmn6;->e:I

    return-void
.end method
