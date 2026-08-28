.class public final Lzn6;
.super Lfzh;
.source "SourceFile"

# interfaces
.implements Lbb8;


# instance fields
.field public final synthetic E:I

.field public final synthetic F:Lqn6;


# direct methods
.method public synthetic constructor <init>(Lqn6;Le85;I)V
    .locals 0

    iput p3, p0, Lzn6;->E:I

    iput-object p1, p0, Lzn6;->F:Lqn6;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p2}, Lfzh;-><init>(ILe85;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Le85;)Le85;
    .locals 1

    iget p1, p0, Lzn6;->E:I

    iget-object p0, p0, Lzn6;->F:Lqn6;

    packed-switch p1, :pswitch_data_0

    new-instance p1, Lzn6;

    const/4 v0, 0x3

    invoke-direct {p1, p0, p2, v0}, Lzn6;-><init>(Lqn6;Le85;I)V

    return-object p1

    :pswitch_0
    new-instance p1, Lzn6;

    const/4 v0, 0x2

    invoke-direct {p1, p0, p2, v0}, Lzn6;-><init>(Lqn6;Le85;I)V

    return-object p1

    :pswitch_1
    new-instance p1, Lzn6;

    const/4 v0, 0x1

    invoke-direct {p1, p0, p2, v0}, Lzn6;-><init>(Lqn6;Le85;I)V

    return-object p1

    :pswitch_2
    new-instance p1, Lzn6;

    const/4 v0, 0x0

    invoke-direct {p1, p0, p2, v0}, Lzn6;-><init>(Lqn6;Le85;I)V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iget v0, p0, Lzn6;->E:I

    sget-object v1, Lx7j;->a:Lx7j;

    check-cast p1, Lxb5;

    check-cast p2, Le85;

    packed-switch v0, :pswitch_data_0

    invoke-virtual {p0, p1, p2}, Lzn6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lzn6;

    invoke-virtual {p0, v1}, Lzn6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1

    :pswitch_0
    invoke-virtual {p0, p1, p2}, Lzn6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lzn6;

    invoke-virtual {p0, v1}, Lzn6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1

    :pswitch_1
    invoke-virtual {p0, p1, p2}, Lzn6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lzn6;

    invoke-virtual {p0, v1}, Lzn6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1

    :pswitch_2
    invoke-virtual {p0, p1, p2}, Lzn6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lzn6;

    invoke-virtual {p0, v1}, Lzn6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iget p0, p0, Lzn6;->E:I

    sget-object v0, Lx7j;->a:Lx7j;

    packed-switch p0, :pswitch_data_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v0

    :pswitch_0
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v0

    :pswitch_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v0

    :pswitch_2
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
