.class public final Lin6;
.super Lfzh;
.source "SourceFile"

# interfaces
.implements Lbb8;


# instance fields
.field public final synthetic E:I

.field public F:Lh0f;

.field public G:Lh0f;

.field public H:I

.field public synthetic I:Ljava/lang/Object;

.field public final synthetic J:Ljn6;


# direct methods
.method public constructor <init>(Lh0f;Ljn6;Le85;)V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lin6;->E:I

    iput-object p1, p0, Lin6;->G:Lh0f;

    iput-object p2, p0, Lin6;->J:Ljn6;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lfzh;-><init>(ILe85;)V

    return-void
.end method

.method public constructor <init>(Ljn6;Le85;)V
    .locals 1

    const/4 v0, 0x1

    iput v0, p0, Lin6;->E:I

    .line 12
    iput-object p1, p0, Lin6;->J:Ljn6;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p2}, Lfzh;-><init>(ILe85;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Le85;)Le85;
    .locals 2

    iget v0, p0, Lin6;->E:I

    iget-object v1, p0, Lin6;->J:Ljn6;

    packed-switch v0, :pswitch_data_0

    new-instance p0, Lin6;

    invoke-direct {p0, v1, p2}, Lin6;-><init>(Ljn6;Le85;)V

    iput-object p1, p0, Lin6;->I:Ljava/lang/Object;

    return-object p0

    :pswitch_0
    new-instance v0, Lin6;

    iget-object p0, p0, Lin6;->G:Lh0f;

    invoke-direct {v0, p0, v1, p2}, Lin6;-><init>(Lh0f;Ljn6;Le85;)V

    iput-object p1, v0, Lin6;->I:Ljava/lang/Object;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method

.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iget v0, p0, Lin6;->E:I

    sget-object v1, Lx7j;->a:Lx7j;

    packed-switch v0, :pswitch_data_0

    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lin6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lin6;

    invoke-virtual {p0, v1}, Lin6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_0
    check-cast p1, Lna8;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lin6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lin6;

    invoke-virtual {p0, v1}, Lin6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    iget v0, p0, Lin6;->E:I

    sget-object v1, Lx7j;->a:Lx7j;

    const/4 v2, 0x1

    const-string v3, "call to \'resume\' before \'invoke\' with coroutine"

    sget-object v4, Lyb5;->E:Lyb5;

    iget-object v5, p0, Lin6;->J:Ljn6;

    const/4 v6, 0x0

    packed-switch v0, :pswitch_data_0

    iget v0, p0, Lin6;->H:I

    packed-switch v0, :pswitch_data_1

    invoke-static {v3}, Lla7;->k(Ljava/lang/String;)V

    move-object v1, v6

    goto/16 :goto_9

    :pswitch_0
    iget-object v0, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v0, Lxb5;

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v0, Lxb5;

    :goto_0
    :try_start_0
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/util/concurrent/CancellationException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_1

    :pswitch_2
    iget-object v0, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v0, Lxb5;

    goto :goto_0

    :cond_0
    :goto_1
    move-object v7, v0

    goto :goto_2

    :pswitch_3
    iget-object v0, p0, Lin6;->F:Lh0f;

    iget-object v3, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v3, Lxb5;

    :try_start_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1 .. :try_end_1} :catch_0

    :cond_1
    move-object v7, v3

    goto/16 :goto_6

    :catch_0
    move-object v0, v3

    goto/16 :goto_7

    :pswitch_4
    iget-object v0, p0, Lin6;->F:Lh0f;

    iget-object v3, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v3, Lxb5;

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_5

    :pswitch_5
    iget-object v0, p0, Lin6;->G:Lh0f;

    iget-object v3, p0, Lin6;->F:Lh0f;

    iget-object v7, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v7, Lxb5;

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_3

    :pswitch_6
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lin6;->I:Ljava/lang/Object;

    check-cast p1, Lxb5;

    move-object v7, p1

    :cond_2
    :goto_2
    invoke-static {v7}, Ld2i;->M(Lxb5;)Z

    move-result p1

    if-eqz p1, :cond_7

    new-instance v0, Lh0f;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iget-object p1, v5, Ljn6;->Z:Lq52;

    if-eqz p1, :cond_4

    iput-object v7, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v0, p0, Lin6;->F:Lh0f;

    iput-object v0, p0, Lin6;->G:Lh0f;

    iput v2, p0, Lin6;->H:I

    invoke-static {p1, p0}, Lq52;->K(Lq52;Le85;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v4, :cond_3

    goto/16 :goto_8

    :cond_3
    move-object v3, v0

    :goto_3
    check-cast p1, Lsm6;

    goto :goto_4

    :cond_4
    move-object v3, v0

    move-object p1, v6

    :goto_4
    iput-object p1, v0, Lh0f;->E:Ljava/lang/Object;

    iget-object p1, v3, Lh0f;->E:Ljava/lang/Object;

    instance-of v0, p1, Lqm6;

    if-eqz v0, :cond_2

    check-cast p1, Lqm6;

    iput-object v7, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v3, p0, Lin6;->F:Lh0f;

    iput-object v6, p0, Lin6;->G:Lh0f;

    const/4 v0, 0x2

    iput v0, p0, Lin6;->H:I

    invoke-static {v5, p1, p0}, Ljn6;->t1(Ljn6;Lqm6;Lg85;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v4, :cond_5

    goto :goto_8

    :cond_5
    move-object v0, v3

    move-object v3, v7

    :goto_5
    :try_start_2
    new-instance p1, Lin6;

    invoke-direct {p1, v0, v5, v6}, Lin6;-><init>(Lh0f;Ljn6;Le85;)V

    iput-object v3, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v0, p0, Lin6;->F:Lh0f;

    const/4 v7, 0x3

    iput v7, p0, Lin6;->H:I

    invoke-virtual {v5, p1, p0}, Ljn6;->w1(Lin6;Lin6;)Ljava/lang/Object;

    move-result-object p1
    :try_end_2
    .catch Ljava/util/concurrent/CancellationException; {:try_start_2 .. :try_end_2} :catch_0

    if-ne p1, v4, :cond_1

    goto :goto_8

    :goto_6
    :try_start_3
    iget-object p1, v0, Lh0f;->E:Ljava/lang/Object;

    instance-of v0, p1, Lrm6;

    if-eqz v0, :cond_6

    check-cast p1, Lrm6;

    iput-object v7, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v6, p0, Lin6;->F:Lh0f;

    const/4 v0, 0x4

    iput v0, p0, Lin6;->H:I

    invoke-static {v5, p1, p0}, Ljn6;->u1(Ljn6;Lrm6;Lg85;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v4, :cond_2

    goto :goto_8

    :catch_1
    move-object v0, v7

    goto :goto_7

    :cond_6
    instance-of p1, p1, Lom6;

    if-eqz p1, :cond_2

    iput-object v7, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v6, p0, Lin6;->F:Lh0f;

    const/4 p1, 0x5

    iput p1, p0, Lin6;->H:I

    invoke-static {v5, p0}, Ljn6;->s1(Ljn6;Lg85;)Ljava/lang/Object;

    move-result-object p1
    :try_end_3
    .catch Ljava/util/concurrent/CancellationException; {:try_start_3 .. :try_end_3} :catch_1

    if-ne p1, v4, :cond_2

    goto :goto_8

    :catch_2
    :goto_7
    iput-object v0, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v6, p0, Lin6;->F:Lh0f;

    const/4 p1, 0x6

    iput p1, p0, Lin6;->H:I

    invoke-static {v5, p0}, Ljn6;->s1(Ljn6;Lg85;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v4, :cond_0

    :goto_8
    move-object v1, v4

    :cond_7
    :goto_9
    return-object v1

    :pswitch_7
    iget-object v0, p0, Lin6;->G:Lh0f;

    iget v7, p0, Lin6;->H:I

    if-eqz v7, :cond_9

    if-ne v7, v2, :cond_8

    iget-object v3, p0, Lin6;->F:Lh0f;

    iget-object v7, p0, Lin6;->I:Ljava/lang/Object;

    check-cast v7, Lna8;

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_c

    :cond_8
    invoke-static {v3}, Lla7;->k(Ljava/lang/String;)V

    move-object v1, v6

    goto :goto_e

    :cond_9
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lin6;->I:Ljava/lang/Object;

    check-cast p1, Lna8;

    move-object v7, p1

    :goto_a
    iget-object p1, v0, Lh0f;->E:Ljava/lang/Object;

    instance-of v3, p1, Lrm6;

    if-nez v3, :cond_e

    instance-of v3, p1, Lom6;

    if-nez v3, :cond_e

    instance-of v3, p1, Lpm6;

    if-eqz v3, :cond_a

    check-cast p1, Lpm6;

    goto :goto_b

    :cond_a
    move-object p1, v6

    :goto_b
    if-eqz p1, :cond_b

    invoke-interface {v7, p1}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_b
    iget-object p1, v5, Ljn6;->Z:Lq52;

    if-eqz p1, :cond_d

    iput-object v7, p0, Lin6;->I:Ljava/lang/Object;

    iput-object v0, p0, Lin6;->F:Lh0f;

    iput v2, p0, Lin6;->H:I

    invoke-static {p1, p0}, Lq52;->K(Lq52;Le85;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v4, :cond_c

    move-object v1, v4

    goto :goto_e

    :cond_c
    move-object v3, v0

    :goto_c
    check-cast p1, Lsm6;

    goto :goto_d

    :cond_d
    move-object v3, v0

    move-object p1, v6

    :goto_d
    iput-object p1, v3, Lh0f;->E:Ljava/lang/Object;

    goto :goto_a

    :cond_e
    :goto_e
    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
