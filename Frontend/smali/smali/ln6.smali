.class public final Lln6;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroidx/compose/ui/input/pointer/PointerInputEventHandler;


# instance fields
.field public final synthetic E:Lla8;

.field public final synthetic F:Lla8;


# direct methods
.method public constructor <init>(Lla8;Lla8;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lln6;->E:Lla8;

    iput-object p2, p0, Lln6;->F:Lla8;

    return-void
.end method


# virtual methods
.method public final invoke(Llud;Le85;)Ljava/lang/Object;
    .locals 4

    new-instance v0, Lf;

    const/4 v1, 0x0

    const/4 v2, 0x2

    iget-object v3, p0, Lln6;->E:Lla8;

    iget-object p0, p0, Lln6;->F:Lla8;

    invoke-direct {v0, v3, p0, v1, v2}, Lf;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    invoke-static {p1, v0, p2}, Lfol;->d(Llud;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_0

    return-object p0

    :cond_0
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method
