.class public final Lyn6;
.super Lfzh;
.source "SourceFile"

# interfaces
.implements Ldb8;


# instance fields
.field public final synthetic E:I


# direct methods
.method public synthetic constructor <init>(IILe85;)V
    .locals 0

    iput p2, p0, Lyn6;->E:I

    invoke-direct {p0, p1, p3}, Lfzh;-><init>(ILe85;)V

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iget p0, p0, Lyn6;->E:I

    sget-object v0, Lx7j;->a:Lx7j;

    const/4 v1, 0x3

    check-cast p1, Lxb5;

    packed-switch p0, :pswitch_data_0

    check-cast p2, Ljava/lang/Number;

    invoke-virtual {p2}, Ljava/lang/Number;->floatValue()F

    check-cast p3, Le85;

    new-instance p0, Lyn6;

    const/4 p1, 0x1

    invoke-direct {p0, v1, p1, p3}, Lyn6;-><init>(IILe85;)V

    invoke-virtual {p0, v0}, Lyn6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0

    :pswitch_0
    check-cast p2, Lmwc;

    iget-wide p0, p2, Lmwc;->a:J

    check-cast p3, Le85;

    new-instance p0, Lyn6;

    const/4 p1, 0x0

    invoke-direct {p0, v1, p1, p3}, Lyn6;-><init>(IILe85;)V

    invoke-virtual {p0, v0}, Lyn6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iget p0, p0, Lyn6;->E:I

    sget-object v0, Lx7j;->a:Lx7j;

    packed-switch p0, :pswitch_data_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v0

    :pswitch_0
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
