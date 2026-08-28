.class public final Lan6;
.super Lljf;
.source "SourceFile"

# interfaces
.implements Lbb8;


# instance fields
.field public final synthetic F:I

.field public G:I

.field public synthetic H:Ljava/lang/Object;

.field public I:Ljava/lang/Object;

.field public J:Ljava/io/Serializable;

.field public final synthetic K:Ljava/lang/Object;

.field public final synthetic L:Ljava/lang/Object;


# direct methods
.method public constructor <init>(Lpt5;Lbo6;Lbo6;Lbb8;Le85;)V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Lan6;->F:I

    iput-object p1, p0, Lan6;->I:Ljava/lang/Object;

    iput-object p2, p0, Lan6;->J:Ljava/io/Serializable;

    iput-object p3, p0, Lan6;->K:Ljava/lang/Object;

    iput-object p4, p0, Lan6;->L:Ljava/lang/Object;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p5}, Lljf;-><init>(ILe85;)V

    return-void
.end method

.method public constructor <init>(Lvgc;Lvgc;Le85;)V
    .locals 1

    const/4 v0, 0x1

    iput v0, p0, Lan6;->F:I

    .line 16
    iput-object p1, p0, Lan6;->K:Ljava/lang/Object;

    iput-object p2, p0, Lan6;->L:Ljava/lang/Object;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lljf;-><init>(ILe85;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Le85;)Le85;
    .locals 9

    iget v0, p0, Lan6;->F:I

    iget-object v1, p0, Lan6;->L:Ljava/lang/Object;

    iget-object v2, p0, Lan6;->K:Ljava/lang/Object;

    packed-switch v0, :pswitch_data_0

    new-instance p0, Lan6;

    check-cast v2, Lvgc;

    check-cast v1, Lvgc;

    invoke-direct {p0, v2, v1, p2}, Lan6;-><init>(Lvgc;Lvgc;Le85;)V

    iput-object p1, p0, Lan6;->H:Ljava/lang/Object;

    return-object p0

    :pswitch_0
    new-instance v3, Lan6;

    iget-object v0, p0, Lan6;->I:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Lpt5;

    iget-object p0, p0, Lan6;->J:Ljava/io/Serializable;

    move-object v5, p0

    check-cast v5, Lbo6;

    move-object v6, v2

    check-cast v6, Lbo6;

    move-object v7, v1

    check-cast v7, Lbb8;

    move-object v8, p2

    invoke-direct/range {v3 .. v8}, Lan6;-><init>(Lpt5;Lbo6;Lbo6;Lbb8;Le85;)V

    iput-object p1, v3, Lan6;->H:Ljava/lang/Object;

    return-object v3

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method

.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iget v0, p0, Lan6;->F:I

    sget-object v1, Lx7j;->a:Lx7j;

    check-cast p1, Llzh;

    check-cast p2, Le85;

    packed-switch v0, :pswitch_data_0

    invoke-virtual {p0, p1, p2}, Lan6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lan6;

    invoke-virtual {p0, v1}, Lan6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_0
    invoke-virtual {p0, p1, p2}, Lan6;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lan6;

    invoke-virtual {p0, v1}, Lan6;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 16

    move-object/from16 v0, p0

    iget v1, v0, Lan6;->F:I

    sget-object v2, Lx7j;->a:Lx7j;

    iget-object v3, v0, Lan6;->L:Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "call to \'resume\' before \'invoke\' with coroutine"

    sget-object v6, Lyb5;->E:Lyb5;

    const/4 v7, 0x2

    const/4 v8, 0x3

    iget-object v9, v0, Lan6;->K:Ljava/lang/Object;

    const/4 v10, 0x1

    const/4 v11, 0x0

    packed-switch v1, :pswitch_data_0

    check-cast v9, Lvgc;

    iget-object v1, v0, Lan6;->H:Ljava/lang/Object;

    check-cast v1, Llzh;

    iget v12, v0, Lan6;->G:I

    if-eqz v12, :cond_3

    if-eq v12, v10, :cond_2

    if-eq v12, v7, :cond_1

    if-ne v12, v8, :cond_0

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto/16 :goto_3

    :cond_0
    invoke-static {v5}, Lla7;->k(Ljava/lang/String;)V

    move-object v2, v11

    goto/16 :goto_3

    :cond_1
    iget-object v4, v0, Lan6;->J:Ljava/io/Serializable;

    check-cast v4, Lh0f;

    iget-object v5, v0, Lan6;->I:Ljava/lang/Object;

    check-cast v5, Lfud;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v12, v4

    move-object/from16 v4, p1

    goto :goto_1

    :cond_2
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v5, p1

    goto :goto_0

    :cond_3
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iput-object v1, v0, Lan6;->H:Ljava/lang/Object;

    iput v10, v0, Lan6;->G:I

    invoke-static {v1, v0, v7}, Ly3i;->b(Llzh;Le85;I)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v6, :cond_4

    goto :goto_2

    :cond_4
    :goto_0
    check-cast v5, Lfud;

    new-instance v12, Lh0f;

    invoke-direct {v12}, Ljava/lang/Object;-><init>()V

    iget-wide v13, v5, Lfud;->a:J

    new-instance v15, Lkr9;

    invoke-direct {v15, v4, v12}, Lkr9;-><init>(ILjava/lang/Object;)V

    iput-object v1, v0, Lan6;->H:Ljava/lang/Object;

    iput-object v5, v0, Lan6;->I:Ljava/lang/Object;

    iput-object v12, v0, Lan6;->J:Ljava/io/Serializable;

    iput v7, v0, Lan6;->G:I

    invoke-static {v1, v13, v14, v15, v0}, Ldn6;->d(Llzh;JLbb8;Lti1;)Ljava/lang/Object;

    move-result-object v4

    if-ne v4, v6, :cond_5

    goto :goto_2

    :cond_5
    :goto_1
    check-cast v4, Lfud;

    if-eqz v4, :cond_7

    iget-object v3, v12, Lh0f;->E:Ljava/lang/Object;

    check-cast v3, Lmwc;

    if-eqz v3, :cond_6

    iget-wide v12, v3, Lmwc;->a:J

    invoke-interface {v9}, Lnlh;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lmwc;

    iget-wide v14, v3, Lmwc;->a:J

    invoke-static {v14, v15, v12, v13}, Lmwc;->i(JJ)J

    move-result-wide v12

    new-instance v3, Lmwc;

    invoke-direct {v3, v12, v13}, Lmwc;-><init>(J)V

    invoke-interface {v9, v3}, Lvgc;->setValue(Ljava/lang/Object;)V

    :cond_6
    iget-wide v3, v4, Lfud;->a:J

    new-instance v5, Lfi4;

    const/16 v7, 0x17

    invoke-direct {v5, v7, v9}, Lfi4;-><init>(ILvgc;)V

    iput-object v11, v0, Lan6;->H:Ljava/lang/Object;

    iput-object v11, v0, Lan6;->I:Ljava/lang/Object;

    iput-object v11, v0, Lan6;->J:Ljava/io/Serializable;

    iput v8, v0, Lan6;->G:I

    invoke-static {v1, v3, v4, v5, v0}, Ldn6;->f(Llzh;JLna8;Lti1;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v6, :cond_8

    :goto_2
    move-object v2, v6

    goto :goto_3

    :cond_7
    invoke-virtual {v5}, Lfud;->l()Z

    move-result v0

    if-nez v0, :cond_8

    check-cast v3, Lvgc;

    invoke-interface {v3}, Lnlh;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    xor-int/2addr v0, v10

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {v3, v0}, Lvgc;->setValue(Ljava/lang/Object;)V

    :cond_8
    :goto_3
    return-object v2

    :pswitch_0
    check-cast v9, Lbo6;

    iget v1, v0, Lan6;->G:I

    if-eqz v1, :cond_c

    if-eq v1, v10, :cond_b

    if-eq v1, v7, :cond_a

    if-ne v1, v8, :cond_9

    iget-object v1, v0, Lan6;->H:Ljava/lang/Object;

    check-cast v1, Llzh;

    :try_start_0
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/util/concurrent/CancellationException; {:try_start_0 .. :try_end_0} :catch_0

    move-object/from16 v3, p1

    goto/16 :goto_7

    :catch_0
    move-exception v0

    goto/16 :goto_a

    :cond_9
    invoke-static {v5}, Lla7;->k(Ljava/lang/String;)V

    move-object v2, v11

    goto/16 :goto_9

    :cond_a
    iget-object v1, v0, Lan6;->H:Ljava/lang/Object;

    check-cast v1, Llzh;

    :try_start_1
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1 .. :try_end_1} :catch_0

    move-object/from16 v5, p1

    goto :goto_5

    :cond_b
    iget-object v1, v0, Lan6;->H:Ljava/lang/Object;

    check-cast v1, Llzh;

    :try_start_2
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/util/concurrent/CancellationException; {:try_start_2 .. :try_end_2} :catch_0

    move-object/from16 v5, p1

    goto :goto_4

    :cond_c
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v0, Lan6;->H:Ljava/lang/Object;

    check-cast v1, Llzh;

    :try_start_3
    iput-object v1, v0, Lan6;->H:Ljava/lang/Object;

    iput v10, v0, Lan6;->G:I

    invoke-static {v1, v0, v7}, Ly3i;->b(Llzh;Le85;I)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v6, :cond_d

    goto :goto_6

    :cond_d
    :goto_4
    check-cast v5, Lfud;

    iget-wide v12, v5, Lfud;->a:J

    iput-object v1, v0, Lan6;->H:Ljava/lang/Object;

    iput v7, v0, Lan6;->G:I

    invoke-static {v1, v12, v13, v0}, Ldn6;->c(Llzh;JLti1;)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v6, :cond_e

    goto :goto_6

    :cond_e
    :goto_5
    check-cast v5, Lfud;

    if-eqz v5, :cond_13

    iget-object v7, v0, Lan6;->I:Ljava/lang/Object;

    check-cast v7, Lpt5;

    iget-wide v12, v5, Lfud;->c:J

    iget-object v14, v7, Lpt5;->H:Ljava/lang/Object;

    check-cast v14, Lvgc;

    sget-object v15, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v14, v15}, Lvgc;->setValue(Ljava/lang/Object;)V

    iget-object v14, v7, Lpt5;->J:Ljava/lang/Object;

    check-cast v14, Lvgc;

    new-instance v15, Lqn6;

    invoke-direct {v15}, Ljava/lang/Object;-><init>()V

    iget-object v4, v7, Lpt5;->I:Ljava/lang/Object;

    check-cast v4, Lxb5;

    new-instance v8, Lzn6;

    invoke-direct {v8, v15, v11, v10}, Lzn6;-><init>(Lqn6;Le85;I)V

    const/4 v10, 0x3

    invoke-static {v4, v11, v11, v8, v10}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    invoke-interface {v14, v15}, Lvgc;->setValue(Ljava/lang/Object;)V

    iget-object v4, v7, Lpt5;->G:Ljava/lang/Object;

    check-cast v4, Lna8;

    new-instance v7, Lmwc;

    invoke-direct {v7, v12, v13}, Lmwc;-><init>(J)V

    invoke-interface {v4, v7}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    iget-wide v4, v5, Lfud;->a:J

    check-cast v3, Lbb8;

    new-instance v7, Lff4;

    const/4 v8, 0x5

    invoke-direct {v7, v8, v3}, Lff4;-><init>(ILbb8;)V

    iput-object v1, v0, Lan6;->H:Ljava/lang/Object;

    const/4 v10, 0x3

    iput v10, v0, Lan6;->G:I

    invoke-static {v1, v4, v5, v7, v0}, Ldn6;->f(Llzh;JLna8;Lti1;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v6, :cond_f

    :goto_6
    move-object v2, v6

    goto :goto_9

    :cond_f
    :goto_7
    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-eqz v3, :cond_12

    iget-object v1, v1, Llzh;->J:Lmzh;

    iget-object v1, v1, Lmzh;->X:Lztd;

    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v3, v1

    check-cast v3, Ljava/util/Collection;

    invoke-interface {v3}, Ljava/util/Collection;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_8
    if-ge v4, v3, :cond_11

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lfud;

    invoke-static {v5}, Lnhl;->e(Lfud;)Z

    move-result v6

    if-eqz v6, :cond_10

    invoke-virtual {v5}, Lfud;->a()V

    :cond_10
    add-int/lit8 v4, v4, 0x1

    goto :goto_8

    :cond_11
    iget-object v0, v0, Lan6;->J:Ljava/io/Serializable;

    check-cast v0, Lbo6;

    invoke-virtual {v0}, Lbo6;->a()Ljava/lang/Object;

    goto :goto_9

    :cond_12
    invoke-virtual {v9}, Lbo6;->a()Ljava/lang/Object;
    :try_end_3
    .catch Ljava/util/concurrent/CancellationException; {:try_start_3 .. :try_end_3} :catch_0

    :cond_13
    :goto_9
    return-object v2

    :goto_a
    invoke-virtual {v9}, Lbo6;->a()Ljava/lang/Object;

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
