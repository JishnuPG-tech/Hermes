.class public final Lfn6;
.super Lg85;
.source "SourceFile"


# instance fields
.field public synthetic E:Ljava/lang/Object;

.field public final synthetic F:Ljn6;

.field public G:I


# direct methods
.method public constructor <init>(Ljn6;Lg85;)V
    .locals 0

    iput-object p1, p0, Lfn6;->F:Ljn6;

    invoke-direct {p0, p2}, Lg85;-><init>(Le85;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iput-object p1, p0, Lfn6;->E:Ljava/lang/Object;

    iget p1, p0, Lfn6;->G:I

    const/high16 v0, -0x80000000

    or-int/2addr p1, v0

    iput p1, p0, Lfn6;->G:I

    iget-object p1, p0, Lfn6;->F:Ljn6;

    invoke-static {p1, p0}, Ljn6;->s1(Ljn6;Lg85;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
