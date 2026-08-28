.class public abstract Ldn6;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:F


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/high16 v0, 0x3e000000    # 0.125f

    const/high16 v1, 0x41900000    # 18.0f

    div-float/2addr v0, v1

    sput v0, Ldn6;->a:F

    return-void
.end method

.method public static final a(Llzh;Lfud;Laud;Lti1;)Ljava/lang/Object;
    .locals 17

    move-object/from16 v0, p1

    move-object/from16 v1, p3

    instance-of v2, v1, Lvm6;

    if-eqz v2, :cond_0

    move-object v2, v1

    check-cast v2, Lvm6;

    iget v3, v2, Lvm6;->L:I

    const/high16 v4, -0x80000000

    and-int v5, v3, v4

    if-eqz v5, :cond_0

    sub-int/2addr v3, v4

    iput v3, v2, Lvm6;->L:I

    goto :goto_0

    :cond_0
    new-instance v2, Lvm6;

    invoke-direct {v2, v1}, Lg85;-><init>(Le85;)V

    :goto_0
    iget-object v1, v2, Lvm6;->K:Ljava/lang/Object;

    iget v3, v2, Lvm6;->L:I

    const/4 v4, 0x0

    const/4 v6, 0x1

    if-eqz v3, :cond_2

    if-ne v3, v6, :cond_1

    iget v0, v2, Lvm6;->J:F

    iget v3, v2, Lvm6;->I:I

    iget-object v7, v2, Lvm6;->H:Lgu8;

    iget-object v8, v2, Lvm6;->G:Lg0f;

    iget-object v9, v2, Lvm6;->F:Laud;

    iget-object v10, v2, Lvm6;->E:Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v16, v2

    move v2, v0

    move-object v0, v10

    move-object v10, v8

    move-object v8, v7

    move-object/from16 v7, v16

    goto :goto_2

    :cond_1
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {v0}, Lla7;->k(Ljava/lang/String;)V

    return-object v4

    :cond_2
    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    invoke-static/range {p0 .. p0}, Lfol;->b(Llzh;)Z

    move-result v1

    if-eqz v1, :cond_3

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    :cond_3
    new-instance v1, Lg0f;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iget-wide v7, v0, Lfud;->a:J

    iput-wide v7, v1, Lg0f;->E:J

    invoke-virtual/range {p0 .. p0}, Llzh;->c()Lspj;

    move-result-object v3

    iget v0, v0, Lfud;->i:I

    invoke-static {v3, v0}, Ldn6;->h(Lspj;I)F

    move-result v0

    new-instance v3, Lgu8;

    const/4 v7, 0x3

    invoke-direct {v3, v4, v7}, Lgu8;-><init>(Lh6d;I)V

    move-object v9, v1

    move-object v8, v3

    const/4 v7, 0x0

    move-object/from16 v1, p2

    move-object v3, v2

    move v2, v0

    move-object/from16 v0, p0

    :goto_1
    iput-object v0, v3, Lvm6;->E:Llzh;

    iput-object v1, v3, Lvm6;->F:Laud;

    iput-object v9, v3, Lvm6;->G:Lg0f;

    iput-object v8, v3, Lvm6;->H:Lgu8;

    iput v7, v3, Lvm6;->I:I

    iput v2, v3, Lvm6;->J:F

    iput v6, v3, Lvm6;->L:I

    invoke-virtual {v0, v1, v3}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v10

    sget-object v11, Lyb5;->E:Lyb5;

    if-ne v10, v11, :cond_4

    return-object v11

    :cond_4
    move-object/from16 v16, v9

    move-object v9, v1

    move-object v1, v10

    move-object/from16 v10, v16

    move/from16 v16, v7

    move-object v7, v3

    move/from16 v3, v16

    :goto_2
    check-cast v1, Lztd;

    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v11, v1

    check-cast v11, Ljava/util/Collection;

    invoke-interface {v11}, Ljava/util/Collection;->size()I

    move-result v11

    const/4 v12, 0x0

    :goto_3
    if-ge v12, v11, :cond_6

    invoke-interface {v1, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    move-object v14, v13

    check-cast v14, Lfud;

    iget-wide v14, v14, Lfud;->a:J

    iget-wide v4, v10, Lg0f;->E:J

    invoke-static {v14, v15, v4, v5}, Leij;->o(JJ)Z

    move-result v4

    if-eqz v4, :cond_5

    goto :goto_4

    :cond_5
    add-int/lit8 v12, v12, 0x1

    const/4 v4, 0x0

    goto :goto_3

    :cond_6
    const/4 v13, 0x0

    :goto_4
    check-cast v13, Lfud;

    if-eqz v13, :cond_8

    invoke-static {v13}, Lnhl;->f(Lfud;)Z

    move-result v4

    if-eqz v4, :cond_7

    goto :goto_5

    :cond_7
    invoke-static {v13, v6}, Lnhl;->p(Lfud;Z)J

    move-result-wide v4

    invoke-virtual {v8, v2, v4, v5, v6}, Lgu8;->t(FJZ)J

    move-result-wide v4

    const-wide v11, 0x7fffffff7fffffffL

    and-long/2addr v4, v11

    const-wide v11, 0x7fc000007fc00000L    # 2.247117487993712E307

    cmp-long v4, v4, v11

    if-eqz v4, :cond_d

    move v3, v6

    goto :goto_9

    :cond_8
    :goto_5
    move-object v4, v1

    check-cast v4, Ljava/util/Collection;

    invoke-interface {v4}, Ljava/util/Collection;->size()I

    move-result v4

    const/4 v5, 0x0

    :goto_6
    if-ge v5, v4, :cond_a

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    move-object v12, v11

    check-cast v12, Lfud;

    iget-boolean v12, v12, Lfud;->d:Z

    if-eqz v12, :cond_9

    goto :goto_7

    :cond_9
    add-int/lit8 v5, v5, 0x1

    goto :goto_6

    :cond_a
    const/4 v11, 0x0

    :goto_7
    check-cast v11, Lfud;

    if-nez v11, :cond_c

    if-eqz v3, :cond_b

    move v5, v6

    goto :goto_8

    :cond_b
    const/4 v5, 0x0

    :goto_8
    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    :cond_c
    iget-wide v4, v11, Lfud;->a:J

    iput-wide v4, v10, Lg0f;->E:J

    :cond_d
    :goto_9
    move-object v4, v1

    check-cast v4, Ljava/util/Collection;

    invoke-interface {v4}, Ljava/util/Collection;->size()I

    move-result v4

    const/4 v5, 0x0

    :goto_a
    if-ge v5, v4, :cond_f

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lfud;

    iget-boolean v11, v11, Lfud;->d:Z

    if-eqz v11, :cond_e

    move-object v1, v7

    move v7, v3

    move-object v3, v1

    move-object v1, v9

    move-object v9, v10

    const/4 v4, 0x0

    goto/16 :goto_1

    :cond_e
    add-int/lit8 v5, v5, 0x1

    goto :goto_a

    :cond_f
    if-eqz v3, :cond_10

    move v5, v6

    goto :goto_b

    :cond_10
    const/4 v5, 0x0

    :goto_b
    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public static final b(Llzh;JLg85;)Ljava/lang/Object;
    .locals 12

    instance-of v0, p3, Lwm6;

    if-eqz v0, :cond_0

    move-object v0, p3

    check-cast v0, Lwm6;

    iget v1, v0, Lwm6;->H:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Lwm6;->H:I

    goto :goto_0

    :cond_0
    new-instance v0, Lwm6;

    invoke-direct {v0, p3}, Lg85;-><init>(Le85;)V

    :goto_0
    iget-object p3, v0, Lwm6;->G:Ljava/lang/Object;

    iget v1, v0, Lwm6;->H:I

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_2

    if-ne v1, v2, :cond_1

    iget-object p0, v0, Lwm6;->F:Lg0f;

    iget-object p1, v0, Lwm6;->E:Llzh;

    invoke-static {p3}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v11, p1

    move-object p1, p0

    move-object p0, v11

    goto :goto_2

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v3

    :cond_2
    invoke-static {p3}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p3, p0, Llzh;->J:Lmzh;

    iget-object p3, p3, Lmzh;->X:Lztd;

    invoke-static {p3, p1, p2}, Ldn6;->g(Lztd;J)Z

    move-result p3

    if-eqz p3, :cond_3

    goto/16 :goto_8

    :cond_3
    new-instance p3, Lg0f;

    invoke-direct {p3}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p3, Lg0f;->E:J

    :goto_1
    iput-object p0, v0, Lwm6;->E:Llzh;

    iput-object p3, v0, Lwm6;->F:Lg0f;

    iput v2, v0, Lwm6;->H:I

    sget-object p1, Laud;->F:Laud;

    invoke-virtual {p0, p1, v0}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object p1

    sget-object p2, Lyb5;->E:Lyb5;

    if-ne p1, p2, :cond_4

    return-object p2

    :cond_4
    move-object v11, p3

    move-object p3, p1

    move-object p1, v11

    :goto_2
    check-cast p3, Lztd;

    iget-object p2, p3, Lztd;->a:Ljava/util/List;

    move-object v1, p2

    check-cast v1, Ljava/util/Collection;

    invoke-interface {v1}, Ljava/util/Collection;->size()I

    move-result v1

    const/4 v4, 0x0

    move v5, v4

    :goto_3
    if-ge v5, v1, :cond_6

    invoke-interface {p2, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v7, v6

    check-cast v7, Lfud;

    iget-wide v7, v7, Lfud;->a:J

    iget-wide v9, p1, Lg0f;->E:J

    invoke-static {v7, v8, v9, v10}, Leij;->o(JJ)Z

    move-result v7

    if-eqz v7, :cond_5

    goto :goto_4

    :cond_5
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    :cond_6
    move-object v6, v3

    :goto_4
    check-cast v6, Lfud;

    if-nez v6, :cond_7

    move-object v6, v3

    goto :goto_7

    :cond_7
    invoke-static {v6}, Lnhl;->f(Lfud;)Z

    move-result p2

    if-eqz p2, :cond_b

    iget-object p2, p3, Lztd;->a:Ljava/util/List;

    move-object p3, p2

    check-cast p3, Ljava/util/Collection;

    invoke-interface {p3}, Ljava/util/Collection;->size()I

    move-result p3

    :goto_5
    if-ge v4, p3, :cond_9

    invoke-interface {p2, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    move-object v5, v1

    check-cast v5, Lfud;

    iget-boolean v5, v5, Lfud;->d:Z

    if-eqz v5, :cond_8

    goto :goto_6

    :cond_8
    add-int/lit8 v4, v4, 0x1

    goto :goto_5

    :cond_9
    move-object v1, v3

    :goto_6
    check-cast v1, Lfud;

    if-nez v1, :cond_a

    goto :goto_7

    :cond_a
    iget-wide p2, v1, Lfud;->a:J

    iput-wide p2, p1, Lg0f;->E:J

    goto :goto_9

    :cond_b
    invoke-static {v6}, Lnhl;->q(Lfud;)Z

    move-result p2

    if-eqz p2, :cond_d

    :goto_7
    if-eqz v6, :cond_c

    invoke-virtual {v6}, Lfud;->l()Z

    move-result p0

    if-nez p0, :cond_c

    return-object v6

    :cond_c
    :goto_8
    return-object v3

    :cond_d
    :goto_9
    move-object p3, p1

    goto :goto_1
.end method

.method public static final c(Llzh;JLti1;)Ljava/lang/Object;
    .locals 11

    instance-of v0, p3, Lxm6;

    if-eqz v0, :cond_0

    move-object v0, p3

    check-cast v0, Lxm6;

    iget v1, v0, Lxm6;->I:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Lxm6;->I:I

    goto :goto_0

    :cond_0
    new-instance v0, Lxm6;

    invoke-direct {v0, p3}, Lg85;-><init>(Le85;)V

    :goto_0
    iget-object p3, v0, Lxm6;->H:Ljava/lang/Object;

    iget v1, v0, Lxm6;->I:I

    const/4 v2, 0x1

    const/4 v7, 0x0

    if-eqz v1, :cond_2

    if-ne v1, v2, :cond_1

    iget-object p0, v0, Lxm6;->G:Ld0f;

    iget-object p1, v0, Lxm6;->F:Lh0f;

    iget-object p2, v0, Lxm6;->E:Lfud;

    :try_start_0
    invoke-static {p3}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_0
    .catch Landroidx/compose/ui/input/pointer/PointerEventTimeoutCancellationException; {:try_start_0 .. :try_end_0} :catch_1

    goto/16 :goto_3

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_2
    invoke-static {p3}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p3, p0, Llzh;->J:Lmzh;

    iget-object p3, p3, Lmzh;->X:Lztd;

    invoke-static {p3, p1, p2}, Ldn6;->g(Lztd;J)Z

    move-result p3

    if-eqz p3, :cond_3

    goto :goto_4

    :cond_3
    iget-object p3, p0, Llzh;->J:Lmzh;

    iget-object p3, p3, Lmzh;->X:Lztd;

    iget-object p3, p3, Lztd;->a:Ljava/util/List;

    move-object v1, p3

    check-cast v1, Ljava/util/Collection;

    invoke-interface {v1}, Ljava/util/Collection;->size()I

    move-result v1

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v1, :cond_5

    invoke-interface {p3, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    move-object v5, v4

    check-cast v5, Lfud;

    iget-wide v5, v5, Lfud;->a:J

    invoke-static {v5, v6, p1, p2}, Leij;->o(JJ)Z

    move-result v5

    if-eqz v5, :cond_4

    goto :goto_2

    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_5
    move-object v4, v7

    :goto_2
    move-object p2, v4

    check-cast p2, Lfud;

    if-nez p2, :cond_6

    goto :goto_4

    :cond_6
    new-instance v6, Lh0f;

    invoke-direct {v6}, Ljava/lang/Object;-><init>()V

    new-instance v5, Lh0f;

    invoke-direct {v5}, Ljava/lang/Object;-><init>()V

    iput-object p2, v5, Lh0f;->E:Ljava/lang/Object;

    invoke-virtual {p0}, Llzh;->c()Lspj;

    move-result-object p1

    invoke-interface {p1}, Lspj;->b()J

    move-result-wide v9

    :try_start_1
    new-instance v4, Ld0f;

    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    new-instance v3, Lq53;

    const/4 v8, 0x1

    invoke-direct/range {v3 .. v8}, Lq53;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p2, v0, Lxm6;->E:Lfud;

    iput-object v6, v0, Lxm6;->F:Lh0f;

    iput-object v4, v0, Lxm6;->G:Ld0f;

    iput v2, v0, Lxm6;->I:I

    invoke-virtual {p0, v9, v10, v3, v0}, Llzh;->d(JLbb8;Lti1;)Ljava/lang/Object;

    move-result-object p0
    :try_end_1
    .catch Landroidx/compose/ui/input/pointer/PointerEventTimeoutCancellationException; {:try_start_1 .. :try_end_1} :catch_0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_7

    return-object p1

    :cond_7
    move-object p0, v4

    move-object p1, v6

    :goto_3
    :try_start_2
    iget-boolean p0, p0, Ld0f;->E:Z

    if-eqz p0, :cond_9

    iget-object p0, p1, Lh0f;->E:Ljava/lang/Object;

    check-cast p0, Lfud;
    :try_end_2
    .catch Landroidx/compose/ui/input/pointer/PointerEventTimeoutCancellationException; {:try_start_2 .. :try_end_2} :catch_1

    if-nez p0, :cond_8

    return-object p2

    :cond_8
    return-object p0

    :cond_9
    :goto_4
    return-object v7

    :catch_0
    move-object p1, v6

    :catch_1
    iget-object p0, p1, Lh0f;->E:Ljava/lang/Object;

    check-cast p0, Lfud;

    if-nez p0, :cond_a

    goto :goto_5

    :cond_a
    move-object p2, p0

    :goto_5
    return-object p2
.end method

.method public static final d(Llzh;JLbb8;Lti1;)Ljava/lang/Object;
    .locals 18

    move-wide/from16 v0, p1

    move-object/from16 v2, p4

    instance-of v3, v2, Lym6;

    if-eqz v3, :cond_0

    move-object v3, v2

    check-cast v3, Lym6;

    iget v4, v3, Lym6;->L:I

    const/high16 v5, -0x80000000

    and-int v6, v4, v5

    if-eqz v6, :cond_0

    sub-int/2addr v4, v5

    iput v4, v3, Lym6;->L:I

    goto :goto_0

    :cond_0
    new-instance v3, Lym6;

    invoke-direct {v3, v2}, Lg85;-><init>(Le85;)V

    :goto_0
    iget-object v2, v3, Lym6;->K:Ljava/lang/Object;

    iget v4, v3, Lym6;->L:I

    const-wide/16 v5, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x1

    const/4 v9, 0x0

    sget-object v10, Lyb5;->E:Lyb5;

    if-eqz v4, :cond_3

    if-eq v4, v8, :cond_2

    if-ne v4, v7, :cond_1

    iget v0, v3, Lym6;->J:F

    iget-object v1, v3, Lym6;->I:Lfud;

    iget-object v4, v3, Lym6;->H:Lgu8;

    iget-object v11, v3, Lym6;->G:Lg0f;

    iget-object v12, v3, Lym6;->F:Llzh;

    iget-object v13, v3, Lym6;->E:Lbb8;

    invoke-static {v2}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 p4, v12

    move-object v12, v11

    move-object/from16 v11, p4

    move v15, v7

    move v2, v8

    move-object/from16 p4, v9

    move-wide v6, v5

    move v5, v0

    move-object v0, v13

    goto/16 :goto_a

    :cond_1
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {v0}, Lla7;->k(Ljava/lang/String;)V

    return-object v9

    :cond_2
    iget v0, v3, Lym6;->J:F

    iget-object v1, v3, Lym6;->H:Lgu8;

    iget-object v4, v3, Lym6;->G:Lg0f;

    iget-object v11, v3, Lym6;->F:Llzh;

    iget-object v12, v3, Lym6;->E:Lbb8;

    invoke-static {v2}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v17, v4

    move v4, v0

    move-object v0, v12

    :goto_1
    move-object/from16 v12, v17

    goto :goto_3

    :cond_3
    invoke-static {v2}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    iget-object v4, v2, Llzh;->J:Lmzh;

    iget-object v4, v4, Lmzh;->X:Lztd;

    invoke-static {v4, v0, v1}, Ldn6;->g(Lztd;J)Z

    move-result v4

    if-eqz v4, :cond_4

    move-object/from16 p4, v9

    goto/16 :goto_b

    :cond_4
    invoke-virtual {v2}, Llzh;->c()Lspj;

    move-result-object v4

    invoke-interface {v4}, Lspj;->f()F

    move-result v4

    new-instance v11, Lg0f;

    invoke-direct {v11}, Ljava/lang/Object;-><init>()V

    iput-wide v0, v11, Lg0f;->E:J

    new-instance v0, Lgu8;

    invoke-direct {v0, v9, v5, v6}, Lgu8;-><init>(Ljava/lang/Object;J)V

    move-object v1, v0

    move-object/from16 v0, p3

    :goto_2
    iput-object v0, v3, Lym6;->E:Lbb8;

    iput-object v2, v3, Lym6;->F:Llzh;

    iput-object v11, v3, Lym6;->G:Lg0f;

    iput-object v1, v3, Lym6;->H:Lgu8;

    iput-object v9, v3, Lym6;->I:Lfud;

    iput v4, v3, Lym6;->J:F

    iput v8, v3, Lym6;->L:I

    sget-object v12, Laud;->F:Laud;

    invoke-virtual {v2, v12, v3}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v12

    if-ne v12, v10, :cond_5

    goto/16 :goto_9

    :cond_5
    move-object/from16 v17, v11

    move-object v11, v2

    move-object v2, v12

    goto :goto_1

    :goto_3
    check-cast v2, Lztd;

    iget-object v13, v2, Lztd;->a:Ljava/util/List;

    move-object v14, v13

    check-cast v14, Ljava/util/Collection;

    invoke-interface {v14}, Ljava/util/Collection;->size()I

    move-result v14

    move-object/from16 p4, v9

    const/4 v9, 0x0

    :goto_4
    if-ge v9, v14, :cond_7

    invoke-interface {v13, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v15, v16

    check-cast v15, Lfud;

    iget-wide v5, v15, Lfud;->a:J

    iget-wide v7, v12, Lg0f;->E:J

    invoke-static {v5, v6, v7, v8}, Leij;->o(JJ)Z

    move-result v5

    if-eqz v5, :cond_6

    goto :goto_5

    :cond_6
    add-int/lit8 v9, v9, 0x1

    const-wide/16 v5, 0x0

    const/4 v7, 0x2

    const/4 v8, 0x1

    goto :goto_4

    :cond_7
    move-object/from16 v16, p4

    :goto_5
    move-object/from16 v5, v16

    check-cast v5, Lfud;

    if-nez v5, :cond_8

    goto/16 :goto_b

    :cond_8
    invoke-virtual {v5}, Lfud;->l()Z

    move-result v6

    if-eqz v6, :cond_9

    goto/16 :goto_b

    :cond_9
    invoke-static {v5}, Lnhl;->f(Lfud;)Z

    move-result v6

    if-eqz v6, :cond_d

    iget-object v2, v2, Lztd;->a:Ljava/util/List;

    move-object v5, v2

    check-cast v5, Ljava/util/Collection;

    invoke-interface {v5}, Ljava/util/Collection;->size()I

    move-result v5

    const/4 v6, 0x0

    :goto_6
    if-ge v6, v5, :cond_b

    invoke-interface {v2, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    move-object v8, v7

    check-cast v8, Lfud;

    iget-boolean v8, v8, Lfud;->d:Z

    if-eqz v8, :cond_a

    goto :goto_7

    :cond_a
    add-int/lit8 v6, v6, 0x1

    goto :goto_6

    :cond_b
    move-object/from16 v7, p4

    :goto_7
    check-cast v7, Lfud;

    if-nez v7, :cond_c

    goto :goto_b

    :cond_c
    iget-wide v5, v7, Lfud;->a:J

    iput-wide v5, v12, Lg0f;->E:J

    const/4 v2, 0x1

    const-wide/16 v6, 0x0

    goto :goto_8

    :cond_d
    const/4 v2, 0x1

    invoke-static {v5, v2}, Lnhl;->p(Lfud;Z)J

    move-result-wide v6

    invoke-virtual {v1, v4, v6, v7, v2}, Lgu8;->t(FJZ)J

    move-result-wide v6

    const-wide v8, 0x7fffffff7fffffffL

    and-long/2addr v8, v6

    const-wide v13, 0x7fc000007fc00000L    # 2.247117487993712E307

    cmp-long v8, v8, v13

    if-eqz v8, :cond_f

    new-instance v8, Lmwc;

    invoke-direct {v8, v6, v7}, Lmwc;-><init>(J)V

    invoke-interface {v0, v5, v8}, Lbb8;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {v5}, Lfud;->l()Z

    move-result v6

    if-eqz v6, :cond_e

    return-object v5

    :cond_e
    const-wide/16 v6, 0x0

    iput-wide v6, v1, Lgu8;->E:J

    :goto_8
    move-object/from16 v9, p4

    move v8, v2

    move-wide v5, v6

    move-object v2, v11

    move-object v11, v12

    const/4 v7, 0x2

    goto/16 :goto_2

    :cond_f
    const-wide/16 v6, 0x0

    iput-object v0, v3, Lym6;->E:Lbb8;

    iput-object v11, v3, Lym6;->F:Llzh;

    iput-object v12, v3, Lym6;->G:Lg0f;

    iput-object v1, v3, Lym6;->H:Lgu8;

    iput-object v5, v3, Lym6;->I:Lfud;

    iput v4, v3, Lym6;->J:F

    const/4 v15, 0x2

    iput v15, v3, Lym6;->L:I

    sget-object v8, Laud;->G:Laud;

    invoke-virtual {v11, v8, v3}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v8

    if-ne v8, v10, :cond_10

    :goto_9
    return-object v10

    :cond_10
    move/from16 v17, v4

    move-object v4, v1

    move-object v1, v5

    move/from16 v5, v17

    :goto_a
    invoke-virtual {v1}, Lfud;->l()Z

    move-result v1

    if-eqz v1, :cond_11

    :goto_b
    return-object p4

    :cond_11
    move-object/from16 v9, p4

    move v8, v2

    move-object v1, v4

    move v4, v5

    move-wide v5, v6

    move-object v2, v11

    move-object v11, v12

    move v7, v15

    goto/16 :goto_2
.end method

.method public static final e(Llud;Lna8;Lla8;Lla8;Lbb8;Le85;)Ljava/lang/Object;
    .locals 7

    new-instance v2, Lzo;

    const/16 v0, 0x15

    invoke-direct {v2, v0, p1}, Lzo;-><init>(ILjava/lang/Object;)V

    new-instance v5, Lrz0;

    const/16 p1, 0xa

    invoke-direct {v5, p1, p2}, Lrz0;-><init>(ILla8;)V

    new-instance v1, Lh76;

    const/16 p1, 0xe

    invoke-direct {v1, p1}, Lh76;-><init>(I)V

    new-instance v0, Lzm6;

    const/4 v6, 0x0

    move-object v4, p3

    move-object v3, p4

    invoke-direct/range {v0 .. v6}, Lzm6;-><init>(Lh76;Lzo;Lbb8;Lla8;Lrz0;Le85;)V

    invoke-static {p0, v0, p5}, Lfol;->d(Llud;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lx7j;->a:Lx7j;

    sget-object p2, Lyb5;->E:Lyb5;

    if-ne p0, p2, :cond_0

    goto :goto_0

    :cond_0
    move-object p0, p1

    :goto_0
    if-ne p0, p2, :cond_1

    return-object p0

    :cond_1
    return-object p1
.end method

.method public static final f(Llzh;JLna8;Lti1;)Ljava/lang/Object;
    .locals 4

    instance-of v0, p4, Lbn6;

    if-eqz v0, :cond_0

    move-object v0, p4

    check-cast v0, Lbn6;

    iget v1, v0, Lbn6;->H:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Lbn6;->H:I

    goto :goto_0

    :cond_0
    new-instance v0, Lbn6;

    invoke-direct {v0, p4}, Lg85;-><init>(Le85;)V

    :goto_0
    iget-object p4, v0, Lbn6;->G:Ljava/lang/Object;

    iget v1, v0, Lbn6;->H:I

    const/4 v2, 0x1

    if-eqz v1, :cond_2

    if-ne v1, v2, :cond_1

    iget-object p0, v0, Lbn6;->F:Lna8;

    iget-object p1, v0, Lbn6;->E:Llzh;

    invoke-static {p4}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object p3, p0

    move-object p0, p1

    goto :goto_2

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_2
    invoke-static {p4}, Ld2i;->b0(Ljava/lang/Object;)V

    :goto_1
    iput-object p0, v0, Lbn6;->E:Llzh;

    iput-object p3, v0, Lbn6;->F:Lna8;

    iput v2, v0, Lbn6;->H:I

    invoke-static {p0, p1, p2, v0}, Ldn6;->b(Llzh;JLg85;)Ljava/lang/Object;

    move-result-object p4

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p4, p1, :cond_3

    return-object p1

    :cond_3
    :goto_2
    check-cast p4, Lfud;

    if-nez p4, :cond_4

    sget-object p0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object p0

    :cond_4
    invoke-static {p4}, Lnhl;->f(Lfud;)Z

    move-result p1

    if-eqz p1, :cond_5

    sget-object p0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object p0

    :cond_5
    invoke-interface {p3, p4}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    iget-wide p1, p4, Lfud;->a:J

    goto :goto_1
.end method

.method public static final g(Lztd;J)Z
    .locals 6

    iget-object p0, p0, Lztd;->a:Ljava/util/List;

    move-object v0, p0

    check-cast v0, Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->size()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_1

    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    move-object v4, v3

    check-cast v4, Lfud;

    iget-wide v4, v4, Lfud;->a:J

    invoke-static {v4, v5, p1, p2}, Leij;->o(JJ)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const/4 v3, 0x0

    :goto_1
    check-cast v3, Lfud;

    const/4 p0, 0x1

    if-eqz v3, :cond_2

    iget-boolean p1, v3, Lfud;->d:Z

    if-ne p1, p0, :cond_2

    move v1, p0

    :cond_2
    xor-int/2addr p0, v1

    return p0
.end method

.method public static final h(Lspj;I)F
    .locals 1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    invoke-interface {p0}, Lspj;->f()F

    move-result p0

    sget p1, Ldn6;->a:F

    mul-float/2addr p0, p1

    return p0

    :cond_0
    invoke-interface {p0}, Lspj;->f()F

    move-result p0

    return p0
.end method

.method public static final i(Llzh;Lfud;Lh76;Lzo;Lbb8;Lla8;Lrz0;Lti1;)Ljava/lang/Object;
    .locals 29

    move-object/from16 v0, p0

    move-object/from16 v1, p7

    instance-of v2, v1, Lcn6;

    if-eqz v2, :cond_0

    move-object v2, v1

    check-cast v2, Lcn6;

    iget v3, v2, Lcn6;->T:I

    const/high16 v4, -0x80000000

    and-int v5, v3, v4

    if-eqz v5, :cond_0

    sub-int/2addr v3, v4

    iput v3, v2, Lcn6;->T:I

    goto :goto_0

    :cond_0
    new-instance v2, Lcn6;

    invoke-direct {v2, v1}, Lg85;-><init>(Le85;)V

    :goto_0
    iget-object v1, v2, Lcn6;->S:Ljava/lang/Object;

    iget v3, v2, Lcn6;->T:I

    sget-object v5, Laud;->G:Laud;

    sget-object v6, Laud;->F:Laud;

    const/4 v7, 0x0

    const-wide v16, 0x7fc000007fc00000L    # 2.247117487993712E307

    sget-object v8, Lyb5;->E:Lyb5;

    packed-switch v3, :pswitch_data_0

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {v0}, Lla7;->k(Ljava/lang/String;)V

    return-object v7

    :pswitch_0
    iget-object v0, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v0, Lg0f;

    iget-object v3, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v3, Llzh;

    iget-object v4, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v4, Llzh;

    iget-object v5, v2, Lcn6;->G:Lcb8;

    check-cast v5, Lna8;

    iget-object v9, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v9, Lla8;

    iget-object v10, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v10, Lbb8;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v15, v7

    move-object v7, v5

    move-object v5, v4

    move-object v4, v3

    move-object v3, v2

    move-object v2, v0

    move-object v0, v8

    goto/16 :goto_28

    :pswitch_1
    iget v0, v2, Lcn6;->R:F

    iget-object v3, v2, Lcn6;->P:Lfud;

    iget-object v4, v2, Lcn6;->O:Lgu8;

    iget-object v9, v2, Lcn6;->N:Lg0f;

    const-wide v18, 0x7fffffff7fffffffL

    iget-object v10, v2, Lcn6;->M:Ljava/lang/Object;

    check-cast v10, Llzh;

    iget-object v11, v2, Lcn6;->L:Ljava/lang/Object;

    check-cast v11, Lg0f;

    iget-object v14, v2, Lcn6;->K:Ljava/lang/Object;

    check-cast v14, Lfud;

    iget-object v12, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v12, Lna8;

    iget-object v13, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v13, Lla8;

    iget-object v15, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v15, Lbb8;

    iget-object v7, v2, Lcn6;->G:Lcb8;

    check-cast v7, Ldb8;

    move/from16 p0, v0

    iget-object v0, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v0, Lh6d;

    move-object/from16 p1, v0

    iget-object v0, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v0, Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v1, v15

    move-object v15, v10

    move-object v10, v1

    move-object v1, v0

    move-object/from16 v23, v6

    move-object v0, v8

    move-object v8, v9

    move-object v6, v11

    move-object v9, v5

    move-object v11, v7

    move-object v7, v12

    move-object/from16 v12, p1

    move-object v5, v4

    move/from16 v4, p0

    goto/16 :goto_23

    :pswitch_2
    const-wide v18, 0x7fffffff7fffffffL

    iget v0, v2, Lcn6;->R:F

    iget-object v3, v2, Lcn6;->O:Lgu8;

    iget-object v4, v2, Lcn6;->N:Lg0f;

    iget-object v7, v2, Lcn6;->M:Ljava/lang/Object;

    check-cast v7, Llzh;

    iget-object v9, v2, Lcn6;->L:Ljava/lang/Object;

    check-cast v9, Lg0f;

    iget-object v10, v2, Lcn6;->K:Ljava/lang/Object;

    check-cast v10, Lfud;

    iget-object v11, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v11, Lna8;

    iget-object v12, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v12, Lla8;

    iget-object v13, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v13, Lbb8;

    iget-object v14, v2, Lcn6;->G:Lcb8;

    check-cast v14, Ldb8;

    iget-object v15, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v15, Lh6d;

    move/from16 p0, v0

    iget-object v0, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v0, Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v23, v4

    move/from16 v4, p0

    move-object/from16 p0, v1

    move-object v1, v3

    move-object v3, v2

    move-object v2, v0

    move-object v0, v8

    move-object/from16 v8, v23

    move-object/from16 v23, v14

    move-object v14, v7

    move-object v7, v11

    move-object/from16 v11, v23

    move-object/from16 v23, v6

    move-object v6, v9

    move-object v9, v12

    move-object v12, v15

    goto/16 :goto_1b

    :pswitch_3
    const-wide v18, 0x7fffffff7fffffffL

    iget-object v0, v2, Lcn6;->M:Ljava/lang/Object;

    check-cast v0, Lg0f;

    iget-object v3, v2, Lcn6;->L:Ljava/lang/Object;

    check-cast v3, Lfud;

    iget-object v4, v2, Lcn6;->K:Ljava/lang/Object;

    check-cast v4, Lfud;

    iget-object v7, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v7, Lna8;

    iget-object v9, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v9, Lla8;

    iget-object v10, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v10, Lbb8;

    iget-object v11, v2, Lcn6;->G:Lcb8;

    check-cast v11, Ldb8;

    iget-object v12, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v12, Lh6d;

    iget-object v13, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v13, Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v23, v6

    move-object v6, v0

    move-object v0, v8

    goto/16 :goto_14

    :pswitch_4
    const-wide v18, 0x7fffffff7fffffffL

    iget v0, v2, Lcn6;->R:F

    iget-object v3, v2, Lcn6;->P:Lfud;

    iget-object v7, v2, Lcn6;->O:Lgu8;

    iget-object v9, v2, Lcn6;->N:Lg0f;

    iget-object v10, v2, Lcn6;->M:Ljava/lang/Object;

    check-cast v10, Llzh;

    iget-object v11, v2, Lcn6;->L:Ljava/lang/Object;

    check-cast v11, Lg0f;

    iget-object v12, v2, Lcn6;->K:Ljava/lang/Object;

    check-cast v12, Lfud;

    iget-object v13, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v13, Lna8;

    iget-object v14, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v14, Lla8;

    iget-object v15, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v15, Lbb8;

    iget-object v4, v2, Lcn6;->G:Lcb8;

    check-cast v4, Ldb8;

    move/from16 p0, v0

    iget-object v0, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v0, Lh6d;

    move-object/from16 p1, v0

    iget-object v0, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v0, Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v1, v13

    move-object v13, v0

    move-object v0, v8

    move-object v8, v10

    move-object v10, v1

    move-object v1, v11

    move-object v11, v5

    move-object v5, v7

    move-object v7, v15

    move-object v15, v1

    move/from16 v25, p0

    move-object/from16 v23, v6

    move-object v1, v12

    move-object v12, v9

    move-object v9, v4

    move-object/from16 v4, p1

    goto/16 :goto_e

    :pswitch_5
    const-wide v18, 0x7fffffff7fffffffL

    iget v0, v2, Lcn6;->R:F

    iget-object v3, v2, Lcn6;->O:Lgu8;

    iget-object v4, v2, Lcn6;->N:Lg0f;

    iget-object v7, v2, Lcn6;->M:Ljava/lang/Object;

    check-cast v7, Llzh;

    iget-object v9, v2, Lcn6;->L:Ljava/lang/Object;

    check-cast v9, Lg0f;

    iget-object v10, v2, Lcn6;->K:Ljava/lang/Object;

    check-cast v10, Lfud;

    iget-object v11, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v11, Lna8;

    iget-object v12, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v12, Lla8;

    iget-object v13, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v13, Lbb8;

    iget-object v14, v2, Lcn6;->G:Lcb8;

    check-cast v14, Ldb8;

    iget-object v15, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v15, Lh6d;

    move/from16 p0, v0

    iget-object v0, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v0, Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v23, v0

    move/from16 v0, p0

    move-object/from16 p0, v1

    move-object v1, v3

    move-object v3, v15

    move-object v15, v9

    move-object v9, v14

    move-object/from16 v14, v23

    move-object/from16 v23, v12

    move-object v12, v4

    move-object/from16 v4, v23

    move-object/from16 v23, v13

    move-object v13, v7

    move-object/from16 v7, v23

    :goto_1
    move-object/from16 v23, v6

    goto/16 :goto_7

    :pswitch_6
    const-wide v18, 0x7fffffff7fffffffL

    iget-boolean v0, v2, Lcn6;->Q:Z

    iget-object v3, v2, Lcn6;->K:Ljava/lang/Object;

    check-cast v3, Lna8;

    iget-object v4, v2, Lcn6;->J:Ljava/lang/Object;

    check-cast v4, Lla8;

    iget-object v7, v2, Lcn6;->I:Ljava/lang/Object;

    check-cast v7, Lbb8;

    iget-object v9, v2, Lcn6;->H:Ljava/lang/Object;

    check-cast v9, Ldb8;

    iget-object v10, v2, Lcn6;->G:Lcb8;

    check-cast v10, Lh6d;

    iget-object v11, v2, Lcn6;->F:Ljava/lang/Object;

    check-cast v11, Lfud;

    iget-object v12, v2, Lcn6;->E:Ljava/lang/Object;

    check-cast v12, Llzh;

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v28, v10

    move-object v10, v3

    move-object/from16 v3, v28

    goto :goto_3

    :pswitch_7
    const-wide v18, 0x7fffffff7fffffffL

    invoke-static {v1}, Ld2i;->b0(Ljava/lang/Object;)V

    invoke-virtual/range {p2 .. p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual/range {p1 .. p1}, Lfud;->a()V

    :cond_1
    iput-object v0, v2, Lcn6;->E:Ljava/lang/Object;

    move-object/from16 v3, p1

    iput-object v3, v2, Lcn6;->F:Ljava/lang/Object;

    const/4 v4, 0x0

    iput-object v4, v2, Lcn6;->G:Lcb8;

    move-object/from16 v4, p3

    iput-object v4, v2, Lcn6;->H:Ljava/lang/Object;

    move-object/from16 v7, p4

    iput-object v7, v2, Lcn6;->I:Ljava/lang/Object;

    move-object/from16 v9, p5

    iput-object v9, v2, Lcn6;->J:Ljava/lang/Object;

    move-object/from16 v10, p6

    iput-object v10, v2, Lcn6;->K:Ljava/lang/Object;

    iput-boolean v1, v2, Lcn6;->Q:Z

    const/4 v11, 0x1

    iput v11, v2, Lcn6;->T:I

    const/4 v11, 0x2

    invoke-static {v0, v2, v11}, Ly3i;->b(Llzh;Le85;I)Ljava/lang/Object;

    move-result-object v12

    if-ne v12, v8, :cond_2

    :goto_2
    move-object v0, v8

    goto/16 :goto_27

    :cond_2
    move-object v11, v12

    move-object v12, v0

    move v0, v1

    move-object v1, v11

    move-object v11, v9

    move-object v9, v4

    move-object v4, v11

    move-object v11, v3

    const/4 v3, 0x0

    :goto_3
    check-cast v1, Lfud;

    new-instance v13, Lg0f;

    invoke-direct {v13}, Ljava/lang/Object;-><init>()V

    const-wide/16 v14, 0x0

    iput-wide v14, v13, Lg0f;->E:J

    if-eqz v0, :cond_13

    :goto_4
    iget-wide v14, v1, Lfud;->a:J

    iget v0, v1, Lfud;->i:I

    iget-object v11, v12, Llzh;->J:Lmzh;

    iget-object v11, v11, Lmzh;->X:Lztd;

    invoke-static {v11, v14, v15}, Ldn6;->g(Lztd;J)Z

    move-result v11

    if-eqz v11, :cond_3

    move-object v11, v5

    move-object/from16 v23, v6

    move-object v0, v8

    :goto_5
    const/4 v5, 0x0

    goto/16 :goto_f

    :cond_3
    invoke-virtual {v12}, Llzh;->c()Lspj;

    move-result-object v11

    invoke-static {v11, v0}, Ldn6;->h(Lspj;I)F

    move-result v0

    new-instance v11, Lg0f;

    invoke-direct {v11}, Ljava/lang/Object;-><init>()V

    iput-wide v14, v11, Lg0f;->E:J

    new-instance v14, Lgu8;

    move/from16 p0, v0

    move-object v15, v1

    const-wide/16 v0, 0x0

    invoke-direct {v14, v3, v0, v1}, Lgu8;-><init>(Ljava/lang/Object;J)V

    move/from16 v0, p0

    move-object v1, v15

    move-object v15, v14

    move-object v14, v13

    move-object v13, v12

    :goto_6
    iput-object v13, v2, Lcn6;->E:Ljava/lang/Object;

    iput-object v3, v2, Lcn6;->F:Ljava/lang/Object;

    iput-object v9, v2, Lcn6;->G:Lcb8;

    iput-object v7, v2, Lcn6;->H:Ljava/lang/Object;

    iput-object v4, v2, Lcn6;->I:Ljava/lang/Object;

    iput-object v10, v2, Lcn6;->J:Ljava/lang/Object;

    iput-object v1, v2, Lcn6;->K:Ljava/lang/Object;

    iput-object v14, v2, Lcn6;->L:Ljava/lang/Object;

    iput-object v12, v2, Lcn6;->M:Ljava/lang/Object;

    iput-object v11, v2, Lcn6;->N:Lg0f;

    iput-object v15, v2, Lcn6;->O:Lgu8;

    move-object/from16 p0, v1

    const/4 v1, 0x0

    iput-object v1, v2, Lcn6;->P:Lfud;

    iput v0, v2, Lcn6;->R:F

    const/4 v1, 0x2

    iput v1, v2, Lcn6;->T:I

    invoke-virtual {v12, v6, v2}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v8, :cond_4

    goto :goto_2

    :cond_4
    move-object/from16 v23, v10

    move-object/from16 v10, p0

    move-object/from16 p0, v1

    move-object v1, v15

    move-object v15, v14

    move-object v14, v13

    move-object v13, v12

    move-object v12, v11

    move-object/from16 v11, v23

    goto/16 :goto_1

    :goto_7
    move-object/from16 v6, p0

    check-cast v6, Lztd;

    move-object/from16 v24, v8

    iget-object v8, v6, Lztd;->a:Ljava/util/List;

    move-object/from16 v25, v8

    check-cast v25, Ljava/util/Collection;

    move-object/from16 v26, v5

    invoke-interface/range {v25 .. v25}, Ljava/util/Collection;->size()I

    move-result v5

    move-object/from16 v25, v13

    const/4 v13, 0x0

    :goto_8
    if-ge v13, v5, :cond_6

    invoke-interface {v8, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v27

    move/from16 p0, v5

    move-object/from16 v5, v27

    check-cast v5, Lfud;

    move-object/from16 p1, v10

    move-object/from16 p2, v11

    iget-wide v10, v5, Lfud;->a:J

    move-object/from16 p3, v4

    iget-wide v4, v12, Lg0f;->E:J

    invoke-static {v10, v11, v4, v5}, Leij;->o(JJ)Z

    move-result v4

    if-eqz v4, :cond_5

    goto :goto_9

    :cond_5
    add-int/lit8 v13, v13, 0x1

    move/from16 v5, p0

    move-object/from16 v10, p1

    move-object/from16 v11, p2

    move-object/from16 v4, p3

    goto :goto_8

    :cond_6
    move-object/from16 p3, v4

    move-object/from16 p1, v10

    move-object/from16 p2, v11

    const/16 v27, 0x0

    :goto_9
    move-object/from16 v4, v27

    check-cast v4, Lfud;

    if-nez v4, :cond_7

    :goto_a
    move-object/from16 v1, p1

    move-object/from16 v10, p2

    move-object/from16 v4, p3

    move-object v12, v14

    move-object v13, v15

    move-object/from16 v0, v24

    move-object/from16 v11, v26

    goto/16 :goto_5

    :cond_7
    invoke-virtual {v4}, Lfud;->l()Z

    move-result v5

    if-eqz v5, :cond_8

    goto :goto_a

    :cond_8
    invoke-static {v4}, Lnhl;->f(Lfud;)Z

    move-result v5

    if-eqz v5, :cond_c

    iget-object v4, v6, Lztd;->a:Ljava/util/List;

    move-object v5, v4

    check-cast v5, Ljava/util/Collection;

    invoke-interface {v5}, Ljava/util/Collection;->size()I

    move-result v5

    const/4 v6, 0x0

    :goto_b
    if-ge v6, v5, :cond_a

    invoke-interface {v4, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    move-object v10, v8

    check-cast v10, Lfud;

    iget-boolean v10, v10, Lfud;->d:Z

    if-eqz v10, :cond_9

    goto :goto_c

    :cond_9
    add-int/lit8 v6, v6, 0x1

    goto :goto_b

    :cond_a
    const/4 v8, 0x0

    :goto_c
    check-cast v8, Lfud;

    if-nez v8, :cond_b

    goto :goto_a

    :cond_b
    iget-wide v4, v8, Lfud;->a:J

    iput-wide v4, v12, Lg0f;->E:J

    goto :goto_d

    :cond_c
    const/4 v11, 0x1

    invoke-static {v4, v11}, Lnhl;->p(Lfud;Z)J

    move-result-wide v5

    invoke-virtual {v1, v0, v5, v6, v11}, Lgu8;->t(FJZ)J

    move-result-wide v5

    and-long v10, v5, v18

    cmp-long v8, v10, v16

    if-eqz v8, :cond_e

    invoke-virtual {v4}, Lfud;->a()V

    iput-wide v5, v15, Lg0f;->E:J

    invoke-virtual {v4}, Lfud;->l()Z

    move-result v5

    if-eqz v5, :cond_d

    move-object/from16 v1, p1

    move-object/from16 v10, p2

    move-object v5, v4

    move-object v12, v14

    move-object v13, v15

    move-object/from16 v0, v24

    move-object/from16 v11, v26

    move-object/from16 v4, p3

    goto/16 :goto_f

    :cond_d
    const-wide/16 v4, 0x0

    iput-wide v4, v1, Lgu8;->E:J

    :goto_d
    move-object/from16 v10, p2

    move-object/from16 v4, p3

    move-object v11, v12

    move-object v13, v14

    move-object v14, v15

    move-object/from16 v6, v23

    move-object/from16 v8, v24

    move-object/from16 v12, v25

    move-object/from16 v5, v26

    move-object v15, v1

    move-object/from16 v1, p1

    goto/16 :goto_6

    :cond_e
    iput-object v14, v2, Lcn6;->E:Ljava/lang/Object;

    iput-object v3, v2, Lcn6;->F:Ljava/lang/Object;

    iput-object v9, v2, Lcn6;->G:Lcb8;

    iput-object v7, v2, Lcn6;->H:Ljava/lang/Object;

    move-object/from16 v5, p3

    iput-object v5, v2, Lcn6;->I:Ljava/lang/Object;

    move-object/from16 v10, p2

    iput-object v10, v2, Lcn6;->J:Ljava/lang/Object;

    move-object/from16 v6, p1

    iput-object v6, v2, Lcn6;->K:Ljava/lang/Object;

    iput-object v15, v2, Lcn6;->L:Ljava/lang/Object;

    move-object/from16 v8, v25

    iput-object v8, v2, Lcn6;->M:Ljava/lang/Object;

    iput-object v12, v2, Lcn6;->N:Lg0f;

    iput-object v1, v2, Lcn6;->O:Lgu8;

    iput-object v4, v2, Lcn6;->P:Lfud;

    iput v0, v2, Lcn6;->R:F

    const/4 v11, 0x3

    iput v11, v2, Lcn6;->T:I

    move-object/from16 v11, v26

    invoke-virtual {v8, v11, v2}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v13

    move/from16 v25, v0

    move-object/from16 v0, v24

    if-ne v13, v0, :cond_f

    goto/16 :goto_27

    :cond_f
    move-object v13, v4

    move-object v4, v3

    move-object v3, v13

    move-object v13, v14

    move-object v14, v5

    move-object v5, v1

    move-object v1, v6

    :goto_e
    invoke-virtual {v3}, Lfud;->l()Z

    move-result v3

    if-eqz v3, :cond_12

    move-object v3, v4

    move-object v12, v13

    move-object v4, v14

    move-object v13, v15

    goto/16 :goto_5

    :goto_f
    if-eqz v5, :cond_11

    invoke-virtual {v5}, Lfud;->l()Z

    move-result v6

    if-eqz v6, :cond_10

    goto :goto_10

    :cond_10
    move-object v8, v0

    move-object v5, v11

    move-object/from16 v6, v23

    goto/16 :goto_4

    :cond_11
    :goto_10
    move-object/from16 v28, v11

    move-object v11, v5

    move-object/from16 v5, v28

    goto :goto_11

    :cond_12
    move-object v3, v4

    move-object v4, v14

    move-object v14, v15

    move-object/from16 v6, v23

    move-object v15, v5

    move-object v5, v11

    move-object v11, v12

    move-object v12, v8

    move-object v8, v0

    move/from16 v0, v25

    goto/16 :goto_6

    :cond_13
    move-object/from16 v23, v6

    move-object v0, v8

    :goto_11
    if-nez v11, :cond_2a

    iget-object v6, v12, Llzh;->J:Lmzh;

    iget-object v6, v6, Lmzh;->X:Lztd;

    iget-object v6, v6, Lztd;->a:Ljava/util/List;

    move-object v8, v6

    check-cast v8, Ljava/util/Collection;

    invoke-interface {v8}, Ljava/util/Collection;->size()I

    move-result v8

    const/4 v14, 0x0

    :goto_12
    if-ge v14, v8, :cond_2a

    invoke-interface {v6, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lfud;

    iget-boolean v15, v15, Lfud;->d:Z

    if-eqz v15, :cond_29

    move-object/from16 v28, v4

    move-object v4, v1

    move-object v1, v12

    move-object v12, v3

    move-object v3, v11

    move-object v11, v9

    move-object/from16 v9, v28

    move-object/from16 v28, v10

    move-object v10, v7

    move-object/from16 v7, v28

    :goto_13
    iput-object v1, v2, Lcn6;->E:Ljava/lang/Object;

    iput-object v12, v2, Lcn6;->F:Ljava/lang/Object;

    iput-object v11, v2, Lcn6;->G:Lcb8;

    iput-object v10, v2, Lcn6;->H:Ljava/lang/Object;

    iput-object v9, v2, Lcn6;->I:Ljava/lang/Object;

    iput-object v7, v2, Lcn6;->J:Ljava/lang/Object;

    iput-object v4, v2, Lcn6;->K:Ljava/lang/Object;

    iput-object v3, v2, Lcn6;->L:Ljava/lang/Object;

    iput-object v13, v2, Lcn6;->M:Ljava/lang/Object;

    const/4 v6, 0x0

    iput-object v6, v2, Lcn6;->N:Lg0f;

    iput-object v6, v2, Lcn6;->O:Lgu8;

    iput-object v6, v2, Lcn6;->P:Lfud;

    const/4 v6, 0x4

    iput v6, v2, Lcn6;->T:I

    invoke-virtual {v1, v5, v2}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v6

    if-ne v6, v0, :cond_14

    goto/16 :goto_27

    :cond_14
    move-object/from16 v28, v13

    move-object v13, v1

    move-object v1, v6

    move-object/from16 v6, v28

    :goto_14
    check-cast v1, Lztd;

    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v8, v1

    check-cast v8, Ljava/util/Collection;

    invoke-interface {v8}, Ljava/util/Collection;->size()I

    move-result v8

    const/4 v14, 0x0

    :goto_15
    if-ge v14, v8, :cond_17

    invoke-interface {v1, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lfud;

    invoke-virtual {v15}, Lfud;->l()Z

    move-result v15

    if-eqz v15, :cond_16

    move-object v8, v1

    check-cast v8, Ljava/util/Collection;

    invoke-interface {v8}, Ljava/util/Collection;->size()I

    move-result v8

    const/4 v14, 0x0

    :goto_16
    if-ge v14, v8, :cond_17

    invoke-interface {v1, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lfud;

    iget-boolean v15, v15, Lfud;->d:Z

    if-eqz v15, :cond_15

    move-object v1, v13

    move-object v13, v6

    goto :goto_13

    :cond_15
    add-int/lit8 v14, v14, 0x1

    goto :goto_16

    :cond_16
    add-int/lit8 v14, v14, 0x1

    goto :goto_15

    :cond_17
    move-object v8, v1

    check-cast v8, Ljava/util/Collection;

    invoke-interface {v8}, Ljava/util/Collection;->size()I

    move-result v8

    const/4 v14, 0x0

    :goto_17
    if-ge v14, v8, :cond_28

    invoke-interface {v1, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lfud;

    iget-boolean v15, v15, Lfud;->d:Z

    if-eqz v15, :cond_27

    invoke-static {v1}, Lun4;->w0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lfud;

    if-eqz v1, :cond_18

    iget-wide v14, v1, Lfud;->c:J

    :goto_18
    move-object/from16 p0, v2

    goto :goto_19

    :cond_18
    const-wide/16 v14, 0x0

    goto :goto_18

    :goto_19
    iget-wide v1, v4, Lfud;->c:J

    invoke-static {v14, v15, v1, v2}, Lmwc;->h(JJ)J

    move-result-wide v1

    iget-wide v14, v4, Lfud;->a:J

    iget v3, v4, Lfud;->i:I

    iget-object v8, v13, Llzh;->J:Lmzh;

    iget-object v8, v8, Lmzh;->X:Lztd;

    invoke-static {v8, v14, v15}, Ldn6;->g(Lztd;J)Z

    move-result v8

    if-eqz v8, :cond_19

    move-object v1, v10

    move-object v10, v7

    move-object v7, v1

    move-object/from16 v2, p0

    move-object v1, v4

    move-object v4, v9

    move-object v3, v12

    move-object v12, v13

    move-object v9, v5

    move-object v13, v6

    const/4 v5, 0x0

    goto/16 :goto_24

    :cond_19
    invoke-virtual {v13}, Llzh;->c()Lspj;

    move-result-object v8

    invoke-static {v8, v3}, Ldn6;->h(Lspj;I)F

    move-result v3

    new-instance v8, Lg0f;

    invoke-direct {v8}, Ljava/lang/Object;-><init>()V

    iput-wide v14, v8, Lg0f;->E:J

    new-instance v14, Lgu8;

    invoke-direct {v14, v12, v1, v2}, Lgu8;-><init>(Ljava/lang/Object;J)V

    move-object/from16 v2, p0

    move-object v1, v13

    :goto_1a
    iput-object v1, v2, Lcn6;->E:Ljava/lang/Object;

    iput-object v12, v2, Lcn6;->F:Ljava/lang/Object;

    iput-object v11, v2, Lcn6;->G:Lcb8;

    iput-object v10, v2, Lcn6;->H:Ljava/lang/Object;

    iput-object v9, v2, Lcn6;->I:Ljava/lang/Object;

    iput-object v7, v2, Lcn6;->J:Ljava/lang/Object;

    iput-object v4, v2, Lcn6;->K:Ljava/lang/Object;

    iput-object v6, v2, Lcn6;->L:Ljava/lang/Object;

    iput-object v13, v2, Lcn6;->M:Ljava/lang/Object;

    iput-object v8, v2, Lcn6;->N:Lg0f;

    iput-object v14, v2, Lcn6;->O:Lgu8;

    const/4 v15, 0x0

    iput-object v15, v2, Lcn6;->P:Lfud;

    iput v3, v2, Lcn6;->R:F

    const/4 v15, 0x5

    iput v15, v2, Lcn6;->T:I

    move-object/from16 v22, v1

    move-object/from16 v15, v23

    invoke-virtual {v13, v15, v2}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_1a

    goto/16 :goto_27

    :cond_1a
    move-object/from16 p0, v1

    move-object v1, v14

    move-object/from16 v23, v15

    move-object v14, v13

    move-object v13, v10

    move-object v10, v4

    move v4, v3

    move-object v3, v2

    move-object/from16 v2, v22

    :goto_1b
    move-object/from16 v15, p0

    check-cast v15, Lztd;

    move-object/from16 v24, v0

    iget-object v0, v15, Lztd;->a:Ljava/util/List;

    move-object/from16 v22, v0

    check-cast v22, Ljava/util/Collection;

    move-object/from16 v26, v5

    invoke-interface/range {v22 .. v22}, Ljava/util/Collection;->size()I

    move-result v5

    move-object/from16 v22, v14

    const/4 v14, 0x0

    :goto_1c
    if-ge v14, v5, :cond_1c

    invoke-interface {v0, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v25

    move-object/from16 v27, v0

    move-object/from16 v0, v25

    check-cast v0, Lfud;

    move-object/from16 p1, v9

    move-object/from16 p0, v10

    iget-wide v9, v0, Lfud;->a:J

    move-object v0, v13

    move/from16 p2, v14

    iget-wide v13, v8, Lg0f;->E:J

    invoke-static {v9, v10, v13, v14}, Leij;->o(JJ)Z

    move-result v9

    if-eqz v9, :cond_1b

    goto :goto_1d

    :cond_1b
    add-int/lit8 v14, p2, 0x1

    move-object/from16 v10, p0

    move-object/from16 v9, p1

    move-object v13, v0

    move-object/from16 v0, v27

    goto :goto_1c

    :cond_1c
    move-object/from16 p1, v9

    move-object/from16 p0, v10

    move-object v0, v13

    const/16 v25, 0x0

    :goto_1d
    move-object/from16 v5, v25

    check-cast v5, Lfud;

    if-nez v5, :cond_1d

    :goto_1e
    move-object v1, v12

    move-object v12, v2

    move-object v2, v3

    move-object v3, v1

    move-object/from16 v1, p0

    move-object/from16 v4, p1

    move-object v13, v6

    move-object v10, v7

    move-object/from16 v9, v26

    const/4 v5, 0x0

    :goto_1f
    move-object v7, v0

    move-object/from16 v0, v24

    goto/16 :goto_24

    :cond_1d
    invoke-virtual {v5}, Lfud;->l()Z

    move-result v9

    if-eqz v9, :cond_1e

    goto :goto_1e

    :cond_1e
    invoke-static {v5}, Lnhl;->f(Lfud;)Z

    move-result v9

    if-eqz v9, :cond_22

    iget-object v5, v15, Lztd;->a:Ljava/util/List;

    move-object v9, v5

    check-cast v9, Ljava/util/Collection;

    invoke-interface {v9}, Ljava/util/Collection;->size()I

    move-result v9

    const/4 v10, 0x0

    :goto_20
    if-ge v10, v9, :cond_20

    invoke-interface {v5, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    move-object v14, v13

    check-cast v14, Lfud;

    iget-boolean v14, v14, Lfud;->d:Z

    if-eqz v14, :cond_1f

    goto :goto_21

    :cond_1f
    add-int/lit8 v10, v10, 0x1

    goto :goto_20

    :cond_20
    const/4 v13, 0x0

    :goto_21
    check-cast v13, Lfud;

    if-nez v13, :cond_21

    goto :goto_1e

    :cond_21
    iget-wide v9, v13, Lfud;->a:J

    iput-wide v9, v8, Lg0f;->E:J

    const-wide/16 v9, 0x0

    goto :goto_22

    :cond_22
    const/4 v9, 0x1

    invoke-static {v5, v9}, Lnhl;->p(Lfud;Z)J

    move-result-wide v13

    invoke-virtual {v1, v4, v13, v14, v9}, Lgu8;->t(FJZ)J

    move-result-wide v13

    and-long v9, v13, v18

    cmp-long v9, v9, v16

    if-eqz v9, :cond_24

    invoke-virtual {v5}, Lfud;->a()V

    const/4 v9, 0x0

    invoke-static {v5, v9}, Lnhl;->p(Lfud;Z)J

    move-result-wide v13

    iput-wide v13, v6, Lg0f;->E:J

    invoke-virtual {v5}, Lfud;->l()Z

    move-result v9

    if-eqz v9, :cond_23

    move-object v1, v12

    move-object v12, v2

    move-object v2, v3

    move-object v3, v1

    move-object/from16 v1, p0

    move-object/from16 v4, p1

    move-object v13, v6

    move-object v10, v7

    move-object/from16 v9, v26

    goto :goto_1f

    :cond_23
    const-wide/16 v9, 0x0

    iput-wide v9, v1, Lgu8;->E:J

    :goto_22
    move-object/from16 v9, p1

    move-object v10, v0

    move-object v14, v1

    move-object v1, v2

    move-object v2, v3

    move v3, v4

    move-object/from16 v13, v22

    move-object/from16 v0, v24

    move-object/from16 v5, v26

    move-object/from16 v4, p0

    goto/16 :goto_1a

    :cond_24
    const-wide/16 v9, 0x0

    iput-object v2, v3, Lcn6;->E:Ljava/lang/Object;

    iput-object v12, v3, Lcn6;->F:Ljava/lang/Object;

    iput-object v11, v3, Lcn6;->G:Lcb8;

    iput-object v0, v3, Lcn6;->H:Ljava/lang/Object;

    move-object/from16 v13, p1

    iput-object v13, v3, Lcn6;->I:Ljava/lang/Object;

    iput-object v7, v3, Lcn6;->J:Ljava/lang/Object;

    move-object/from16 v14, p0

    iput-object v14, v3, Lcn6;->K:Ljava/lang/Object;

    iput-object v6, v3, Lcn6;->L:Ljava/lang/Object;

    move-object/from16 v15, v22

    iput-object v15, v3, Lcn6;->M:Ljava/lang/Object;

    iput-object v8, v3, Lcn6;->N:Lg0f;

    iput-object v1, v3, Lcn6;->O:Lgu8;

    iput-object v5, v3, Lcn6;->P:Lfud;

    iput v4, v3, Lcn6;->R:F

    const/4 v9, 0x6

    iput v9, v3, Lcn6;->T:I

    move-object/from16 v9, v26

    invoke-virtual {v15, v9, v3}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v10

    move-object/from16 v22, v0

    move-object/from16 v0, v24

    if-ne v10, v0, :cond_25

    goto/16 :goto_27

    :cond_25
    move-object v10, v5

    move-object v5, v1

    move-object v1, v2

    move-object v2, v3

    move-object v3, v10

    move-object/from16 v10, v22

    :goto_23
    invoke-virtual {v3}, Lfud;->l()Z

    move-result v3

    if-eqz v3, :cond_26

    move-object v3, v10

    move-object v10, v7

    move-object v7, v3

    move-object v3, v12

    move-object v4, v13

    const/4 v5, 0x0

    move-object v12, v1

    move-object v13, v6

    move-object v1, v14

    :goto_24
    move-object/from16 v28, v11

    move-object v11, v5

    move-object v5, v9

    move-object/from16 v9, v28

    goto/16 :goto_11

    :cond_26
    move v3, v4

    move-object v4, v14

    move-object v14, v5

    move-object v5, v9

    move-object v9, v13

    move-object v13, v15

    goto/16 :goto_1a

    :cond_27
    move-object/from16 p0, v2

    move-object/from16 v26, v5

    const-wide/16 v20, 0x0

    add-int/lit8 v14, v14, 0x1

    goto/16 :goto_17

    :cond_28
    move-object/from16 p0, v2

    const-wide/16 v20, 0x0

    move-object v1, v10

    move-object v10, v7

    move-object v7, v1

    move-object v1, v4

    move-object v4, v9

    move-object v9, v11

    move-object v11, v3

    move-object v3, v12

    move-object v12, v13

    move-object v13, v6

    goto/16 :goto_11

    :cond_29
    move-object/from16 v26, v5

    const-wide/16 v20, 0x0

    add-int/lit8 v14, v14, 0x1

    goto/16 :goto_12

    :cond_2a
    if-eqz v11, :cond_39

    iget-wide v5, v13, Lg0f;->E:J

    new-instance v3, Lmwc;

    invoke-direct {v3, v5, v6}, Lmwc;-><init>(J)V

    invoke-interface {v9, v1, v11, v3}, Ldb8;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-wide v5, v13, Lg0f;->E:J

    new-instance v1, Lmwc;

    invoke-direct {v1, v5, v6}, Lmwc;-><init>(J)V

    invoke-interface {v7, v11, v1}, Lbb8;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-wide v5, v11, Lfud;->a:J

    iget-object v1, v12, Llzh;->J:Lmzh;

    iget-object v1, v1, Lmzh;->X:Lztd;

    invoke-static {v1, v5, v6}, Ldn6;->g(Lztd;J)Z

    move-result v1

    if-eqz v1, :cond_2b

    const/4 v7, 0x0

    goto/16 :goto_31

    :cond_2b
    :goto_25
    new-instance v1, Lg0f;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-wide v5, v1, Lg0f;->E:J

    move-object v9, v4

    move-object v5, v10

    move-object v3, v12

    move-object v4, v3

    move-object v10, v7

    :goto_26
    iput-object v10, v2, Lcn6;->E:Ljava/lang/Object;

    iput-object v9, v2, Lcn6;->F:Ljava/lang/Object;

    iput-object v5, v2, Lcn6;->G:Lcb8;

    iput-object v4, v2, Lcn6;->H:Ljava/lang/Object;

    iput-object v3, v2, Lcn6;->I:Ljava/lang/Object;

    iput-object v1, v2, Lcn6;->J:Ljava/lang/Object;

    const/4 v15, 0x0

    iput-object v15, v2, Lcn6;->K:Ljava/lang/Object;

    iput-object v15, v2, Lcn6;->L:Ljava/lang/Object;

    iput-object v15, v2, Lcn6;->M:Ljava/lang/Object;

    iput-object v15, v2, Lcn6;->N:Lg0f;

    iput-object v15, v2, Lcn6;->O:Lgu8;

    iput-object v15, v2, Lcn6;->P:Lfud;

    const/4 v6, 0x7

    iput v6, v2, Lcn6;->T:I

    move-object/from16 v6, v23

    invoke-virtual {v3, v6, v2}, Llzh;->a(Laud;Lti1;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v0, :cond_2c

    :goto_27
    return-object v0

    :cond_2c
    move-object/from16 v28, v2

    move-object v2, v1

    move-object v1, v7

    move-object v7, v5

    move-object v5, v4

    move-object v4, v3

    move-object/from16 v3, v28

    :goto_28
    check-cast v1, Lztd;

    iget-object v8, v1, Lztd;->a:Ljava/util/List;

    move-object v11, v8

    check-cast v11, Ljava/util/Collection;

    invoke-interface {v11}, Ljava/util/Collection;->size()I

    move-result v11

    const/4 v12, 0x0

    :goto_29
    if-ge v12, v11, :cond_2e

    invoke-interface {v8, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    move-object v14, v13

    check-cast v14, Lfud;

    move-object/from16 p0, v3

    move-object/from16 p1, v4

    iget-wide v3, v14, Lfud;->a:J

    move-object/from16 p2, v5

    move-object/from16 v23, v6

    iget-wide v5, v2, Lg0f;->E:J

    invoke-static {v3, v4, v5, v6}, Leij;->o(JJ)Z

    move-result v3

    if-eqz v3, :cond_2d

    move-object v4, v13

    goto :goto_2a

    :cond_2d
    add-int/lit8 v12, v12, 0x1

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move-object/from16 v5, p2

    move-object/from16 v6, v23

    goto :goto_29

    :cond_2e
    move-object/from16 p0, v3

    move-object/from16 p1, v4

    move-object/from16 p2, v5

    move-object/from16 v23, v6

    move-object v4, v15

    :goto_2a
    check-cast v4, Lfud;

    if-nez v4, :cond_2f

    move-object v4, v15

    :goto_2b
    const/4 v11, 0x1

    goto :goto_2f

    :cond_2f
    invoke-static {v4}, Lnhl;->f(Lfud;)Z

    move-result v3

    if-eqz v3, :cond_33

    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v3, v1

    check-cast v3, Ljava/util/Collection;

    invoke-interface {v3}, Ljava/util/Collection;->size()I

    move-result v3

    const/4 v5, 0x0

    :goto_2c
    if-ge v5, v3, :cond_31

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v8, v6

    check-cast v8, Lfud;

    iget-boolean v8, v8, Lfud;->d:Z

    if-eqz v8, :cond_30

    goto :goto_2d

    :cond_30
    add-int/lit8 v5, v5, 0x1

    goto :goto_2c

    :cond_31
    move-object v6, v15

    :goto_2d
    check-cast v6, Lfud;

    if-nez v6, :cond_32

    goto :goto_2b

    :cond_32
    iget-wide v3, v6, Lfud;->a:J

    iput-wide v3, v2, Lg0f;->E:J

    const/4 v11, 0x1

    goto :goto_2e

    :cond_33
    const/4 v11, 0x1

    invoke-static {v4, v11}, Lnhl;->p(Lfud;Z)J

    move-result-wide v5

    invoke-static {v5, v6}, Lmwc;->d(J)F

    move-result v1

    const/4 v3, 0x0

    cmpg-float v1, v1, v3

    if-nez v1, :cond_34

    :goto_2e
    move-object/from16 v3, p1

    move-object/from16 v4, p2

    move-object v1, v2

    move-object v5, v7

    move-object/from16 v2, p0

    goto/16 :goto_26

    :cond_34
    :goto_2f
    if-nez v4, :cond_35

    :goto_30
    move-object v10, v7

    move-object v4, v9

    move-object v7, v15

    goto :goto_31

    :cond_35
    invoke-virtual {v4}, Lfud;->l()Z

    move-result v1

    if-eqz v1, :cond_36

    goto :goto_30

    :cond_36
    invoke-static {v4}, Lnhl;->f(Lfud;)Z

    move-result v1

    if-eqz v1, :cond_38

    move-object v10, v7

    move-object v7, v4

    move-object v4, v9

    :goto_31
    if-nez v7, :cond_37

    invoke-interface {v4}, Lla8;->a()Ljava/lang/Object;

    goto :goto_32

    :cond_37
    invoke-interface {v10, v7}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_32

    :cond_38
    const/4 v1, 0x0

    invoke-static {v4, v1}, Lnhl;->p(Lfud;Z)J

    move-result-wide v2

    new-instance v5, Lmwc;

    invoke-direct {v5, v2, v3}, Lmwc;-><init>(J)V

    invoke-interface {v10, v4, v5}, Lbb8;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {v4}, Lfud;->a()V

    iget-wide v5, v4, Lfud;->a:J

    move-object v2, v10

    move-object v10, v7

    move-object v7, v2

    move-object/from16 v2, p0

    move-object/from16 v12, p2

    move-object v4, v9

    goto/16 :goto_25

    :cond_39
    :goto_32
    sget-object v0, Lx7j;->a:Lx7j;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
