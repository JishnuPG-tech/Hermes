.class public final Lhn6;
.super Lg85;
.source "SourceFile"


# instance fields
.field public E:Lrm6;

.field public synthetic F:Ljava/lang/Object;

.field public final synthetic G:Ljn6;

.field public H:I


# direct methods
.method public constructor <init>(Ljn6;Lg85;)V
    .locals 0

    iput-object p1, p0, Lhn6;->G:Ljn6;

    invoke-direct {p0, p2}, Lg85;-><init>(Le85;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iput-object p1, p0, Lhn6;->F:Ljava/lang/Object;

    iget p1, p0, Lhn6;->H:I

    const/high16 v0, -0x80000000

    or-int/2addr p1, v0

    iput p1, p0, Lhn6;->H:I

    iget-object p1, p0, Lhn6;->G:Ljn6;

    const/4 v0, 0x0

    invoke-static {p1, v0, p0}, Ljn6;->u1(Ljn6;Lrm6;Lg85;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
