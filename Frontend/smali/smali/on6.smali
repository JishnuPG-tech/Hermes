.class public final Lon6;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:J

.field public final b:J

.field public final c:J


# direct methods
.method public constructor <init>(JJJ)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lon6;->a:J

    iput-wide p3, p0, Lon6;->b:J

    iput-wide p5, p0, Lon6;->c:J

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    if-ne p0, p1, :cond_0

    goto :goto_0

    :cond_0
    if-eqz p1, :cond_5

    instance-of v0, p1, Lon6;

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    check-cast p1, Lon6;

    iget-wide v0, p1, Lon6;->a:J

    iget-wide v2, p0, Lon6;->a:J

    invoke-static {v2, v3, v0, v1}, Ldl6;->b(JJ)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    iget-wide v0, p0, Lon6;->b:J

    iget-wide v2, p1, Lon6;->b:J

    invoke-static {v0, v1, v2, v3}, Ldl6;->b(JJ)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_1

    :cond_3
    iget-wide v0, p0, Lon6;->c:J

    iget-wide p0, p1, Lon6;->c:J

    invoke-static {v0, v1, p0, p1}, Ldl6;->b(JJ)Z

    move-result p0

    if-nez p0, :cond_4

    goto :goto_1

    :cond_4
    :goto_0
    const/4 p0, 0x1

    return p0

    :cond_5
    :goto_1
    const/4 p0, 0x0

    return p0
.end method

.method public final hashCode()I
    .locals 4

    iget-wide v0, p0, Lon6;->a:J

    invoke-static {v0, v1}, Ljava/lang/Long;->hashCode(J)I

    move-result v0

    const/16 v1, 0x1f

    mul-int/2addr v0, v1

    iget-wide v2, p0, Lon6;->b:J

    invoke-static {v0, v2, v3, v1}, Lzj6;->f(IJI)I

    move-result v0

    iget-wide v1, p0, Lon6;->c:J

    invoke-static {v1, v2}, Ljava/lang/Long;->hashCode(J)I

    move-result p0

    add-int/2addr p0, v0

    return p0
.end method
