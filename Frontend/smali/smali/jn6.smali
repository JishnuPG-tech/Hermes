.class public abstract Ljn6;
.super Ly56;
.source "SourceFile"

# interfaces
.implements Lkud;
.implements Lrf9;
.implements Ldx4;
.implements Lte8;


# instance fields
.field public U:Lh6d;

.field public V:Lna8;

.field public W:Z

.field public X:Lifc;

.field public Y:Lue8;

.field public Z:Lq52;

.field public a0:Lqn6;

.field public b0:Z

.field public c0:Z

.field public d0:Lkm6;

.field public e0:Lnm6;

.field public f0:Lmm6;

.field public g0:Llm6;

.field public h0:Litk;

.field public i0:Lsaf;

.field public j0:J

.field public k0:Lgu8;

.field public l0:Lqf9;

.field public m0:J


# direct methods
.method public constructor <init>(Lna8;ZLifc;Lh6d;)V
    .locals 0

    invoke-direct {p0}, Ly56;-><init>()V

    iput-object p4, p0, Ljn6;->U:Lh6d;

    iput-object p1, p0, Ljn6;->V:Lna8;

    iput-boolean p2, p0, Ljn6;->W:Z

    iput-object p3, p0, Ljn6;->X:Lifc;

    const-wide p1, 0x7fc000007fc00000L    # 2.247117487993712E307

    iput-wide p1, p0, Ljn6;->j0:J

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Ljn6;->m0:J

    return-void
.end method

.method public static final s1(Ljn6;Lg85;)Ljava/lang/Object;
    .locals 5

    instance-of v0, p1, Lfn6;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Lfn6;

    iget v1, v0, Lfn6;->G:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Lfn6;->G:I

    goto :goto_0

    :cond_0
    new-instance v0, Lfn6;

    invoke-direct {v0, p0, p1}, Lfn6;-><init>(Ljn6;Lg85;)V

    :goto_0
    iget-object p1, v0, Lfn6;->E:Ljava/lang/Object;

    iget v1, v0, Lfn6;->G:I

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_2

    if-ne v1, v3, :cond_1

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v2

    :cond_2
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Ljn6;->a0:Lqn6;

    if-eqz p1, :cond_4

    iget-object v1, p0, Ljn6;->X:Lifc;

    if-eqz v1, :cond_3

    new-instance v4, Lpn6;

    invoke-direct {v4, p1}, Lpn6;-><init>(Lqn6;)V

    iput v3, v0, Lfn6;->G:I

    invoke-virtual {v1, v4, v0}, Lifc;->a(Lem9;Le85;)Ljava/lang/Object;

    move-result-object p1

    sget-object v0, Lyb5;->E:Lyb5;

    if-ne p1, v0, :cond_3

    return-object v0

    :cond_3
    :goto_1
    iput-object v2, p0, Ljn6;->a0:Lqn6;

    :cond_4
    new-instance p1, Lrm6;

    const-wide/16 v0, 0x0

    const/4 v2, 0x0

    invoke-direct {p1, v0, v1, v2}, Lrm6;-><init>(JZ)V

    invoke-virtual {p0, p1}, Ljn6;->C1(Lrm6;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method public static final t1(Ljn6;Lqm6;Lg85;)Ljava/lang/Object;
    .locals 6

    instance-of v0, p2, Lgn6;

    if-eqz v0, :cond_0

    move-object v0, p2

    check-cast v0, Lgn6;

    iget v1, v0, Lgn6;->I:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Lgn6;->I:I

    goto :goto_0

    :cond_0
    new-instance v0, Lgn6;

    invoke-direct {v0, p0, p2}, Lgn6;-><init>(Ljn6;Lg85;)V

    :goto_0
    iget-object p2, v0, Lgn6;->G:Ljava/lang/Object;

    iget v1, v0, Lgn6;->I:I

    const/4 v2, 0x2

    const/4 v3, 0x1

    sget-object v4, Lyb5;->E:Lyb5;

    if-eqz v1, :cond_3

    if-eq v1, v3, :cond_2

    if-ne v1, v2, :cond_1

    iget-object p1, v0, Lgn6;->F:Lqn6;

    iget-object v0, v0, Lgn6;->E:Lqm6;

    invoke-static {p2}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_3

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_2
    iget-object p1, v0, Lgn6;->E:Lqm6;

    invoke-static {p2}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :cond_3
    invoke-static {p2}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p2, p0, Ljn6;->a0:Lqn6;

    if-eqz p2, :cond_4

    iget-object v1, p0, Ljn6;->X:Lifc;

    if-eqz v1, :cond_4

    new-instance v5, Lpn6;

    invoke-direct {v5, p2}, Lpn6;-><init>(Lqn6;)V

    iput-object p1, v0, Lgn6;->E:Lqm6;

    iput v3, v0, Lgn6;->I:I

    invoke-virtual {v1, v5, v0}, Lifc;->a(Lem9;Le85;)Ljava/lang/Object;

    move-result-object p2

    if-ne p2, v4, :cond_4

    goto :goto_2

    :cond_4
    :goto_1
    new-instance p2, Lqn6;

    invoke-direct {p2}, Lqn6;-><init>()V

    iget-object v1, p0, Ljn6;->X:Lifc;

    if-eqz v1, :cond_6

    iput-object p1, v0, Lgn6;->E:Lqm6;

    iput-object p2, v0, Lgn6;->F:Lqn6;

    iput v2, v0, Lgn6;->I:I

    invoke-virtual {v1, p2, v0}, Lifc;->a(Lem9;Le85;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v4, :cond_5

    :goto_2
    return-object v4

    :cond_5
    move-object v0, p1

    move-object p1, p2

    :goto_3
    move-object p2, p1

    move-object p1, v0

    :cond_6
    iput-object p2, p0, Ljn6;->a0:Lqn6;

    invoke-virtual {p1}, Lqm6;->a()J

    move-result-wide p1

    invoke-virtual {p0, p1, p2}, Ljn6;->B1(J)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method public static final u1(Ljn6;Lrm6;Lg85;)Ljava/lang/Object;
    .locals 5

    instance-of v0, p2, Lhn6;

    if-eqz v0, :cond_0

    move-object v0, p2

    check-cast v0, Lhn6;

    iget v1, v0, Lhn6;->H:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Lhn6;->H:I

    goto :goto_0

    :cond_0
    new-instance v0, Lhn6;

    invoke-direct {v0, p0, p2}, Lhn6;-><init>(Ljn6;Lg85;)V

    :goto_0
    iget-object p2, v0, Lhn6;->F:Ljava/lang/Object;

    iget v1, v0, Lhn6;->H:I

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_2

    if-ne v1, v3, :cond_1

    iget-object p1, v0, Lhn6;->E:Lrm6;

    invoke-static {p2}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v2

    :cond_2
    invoke-static {p2}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p2, p0, Ljn6;->a0:Lqn6;

    if-eqz p2, :cond_4

    iget-object v1, p0, Ljn6;->X:Lifc;

    if-eqz v1, :cond_3

    new-instance v4, Lrn6;

    invoke-direct {v4, p2}, Lrn6;-><init>(Lqn6;)V

    iput-object p1, v0, Lhn6;->E:Lrm6;

    iput v3, v0, Lhn6;->H:I

    invoke-virtual {v1, v4, v0}, Lifc;->a(Lem9;Le85;)Ljava/lang/Object;

    move-result-object p2

    sget-object v0, Lyb5;->E:Lyb5;

    if-ne p2, v0, :cond_3

    return-object v0

    :cond_3
    :goto_1
    iput-object v2, p0, Ljn6;->a0:Lqn6;

    :cond_4
    invoke-virtual {p0, p1}, Ljn6;->C1(Lrm6;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method public static z1(Ljn6;Lfud;JJI)V
    .locals 0

    and-int/lit8 p6, p6, 0x4

    if-eqz p6, :cond_0

    const-wide/16 p4, 0x0

    :cond_0
    iget-object p6, p0, Ljn6;->f0:Lmm6;

    if-nez p6, :cond_1

    new-instance p6, Lmm6;

    invoke-direct {p6}, Lmm6;-><init>()V

    iput-object p6, p0, Ljn6;->f0:Lmm6;

    :cond_1
    invoke-virtual {p6, p1}, Lmm6;->s(Lfud;)V

    invoke-virtual {p6, p2, p3}, Lmm6;->t(J)V

    iget-object p1, p0, Ljn6;->k0:Lgu8;

    iget-object p2, p0, Ljn6;->U:Lh6d;

    if-nez p1, :cond_2

    new-instance p1, Lgu8;

    const/4 p3, 0x2

    invoke-direct {p1, p2, p3}, Lgu8;-><init>(Lh6d;I)V

    iput-object p1, p0, Ljn6;->k0:Lgu8;

    goto :goto_0

    :cond_2
    invoke-virtual {p1, p2}, Lgu8;->A(Lh6d;)V

    iget-object p1, p0, Ljn6;->k0:Lgu8;

    if-eqz p1, :cond_3

    invoke-virtual {p1, p4, p5}, Lgu8;->y(J)V

    :cond_3
    :goto_0
    const/4 p1, 0x0

    invoke-virtual {p6, p1}, Lmm6;->u(Z)V

    iput-object p6, p0, Ljn6;->h0:Litk;

    return-void
.end method


# virtual methods
.method public final A(Lw30;Laud;)V
    .locals 1

    iget-object v0, p0, Ljn6;->Y:Lue8;

    if-nez v0, :cond_0

    invoke-static {p0}, Lvpl;->p(Lte8;)Lue8;

    move-result-object v0

    invoke-virtual {p0, v0}, Ly56;->p1(Lv56;)Lv56;

    iput-object v0, p0, Ljn6;->Y:Lue8;

    :cond_0
    iget-boolean v0, p0, Ljn6;->W:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Ljn6;->l0:Lqf9;

    if-nez v0, :cond_1

    new-instance v0, Lqf9;

    invoke-direct {v0, p0}, Lqf9;-><init>(Ljn6;)V

    iput-object v0, p0, Ljn6;->l0:Lqf9;

    :cond_1
    iget-object p0, p0, Ljn6;->l0:Lqf9;

    if-eqz p0, :cond_2

    invoke-virtual {p0, p1, p2}, Lqf9;->d(Lw30;Laud;)V

    :cond_2
    return-void
.end method

.method public final A1(Lsm6;)V
    .locals 1

    instance-of v0, p1, Lqm6;

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Ljn6;->b0:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljn6;->b0:Z

    invoke-virtual {p0}, Ljn6;->I1()V

    :cond_0
    invoke-virtual {p0}, Ljn6;->D1()Llq2;

    move-result-object p0

    invoke-interface {p0, p1}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public abstract B1(J)V
.end method

.method public C(Lztd;Laud;J)V
    .locals 19

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    const/4 v3, 0x1

    iput-boolean v3, v0, Ljn6;->c0:Z

    iget-object v4, v0, Ljn6;->Y:Lue8;

    if-nez v4, :cond_0

    invoke-static {v0}, Lvpl;->p(Lte8;)Lue8;

    move-result-object v4

    invoke-virtual {v0, v4}, Ly56;->p1(Lv56;)Lv56;

    iput-object v4, v0, Ljn6;->Y:Lue8;

    :cond_0
    iget-boolean v4, v0, Ljn6;->W:Z

    if-eqz v4, :cond_38

    iget-object v4, v0, Ljn6;->h0:Litk;

    if-nez v4, :cond_2

    iget-object v4, v0, Ljn6;->d0:Lkm6;

    if-nez v4, :cond_1

    new-instance v4, Lkm6;

    invoke-direct {v4}, Lkm6;-><init>()V

    iput-object v4, v0, Ljn6;->d0:Lkm6;

    :cond_1
    iput-object v4, v0, Ljn6;->h0:Litk;

    :cond_2
    iget-object v4, v0, Ljn6;->h0:Litk;

    if-eqz v4, :cond_37

    instance-of v5, v4, Lkm6;

    sget-object v6, Laud;->E:Laud;

    sget-object v7, Laud;->F:Laud;

    const/4 v8, 0x0

    if-eqz v5, :cond_a

    check-cast v4, Lkm6;

    iget-object v5, v1, Lztd;->a:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_3

    goto/16 :goto_12

    :cond_3
    invoke-static {v1, v8}, Ly3i;->h(Lztd;Z)Z

    move-result v5

    if-nez v5, :cond_4

    goto/16 :goto_12

    :cond_4
    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    invoke-static {v1}, Lun4;->u0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lfud;

    invoke-virtual {v4}, Lkm6;->p()Ljm6;

    move-result-object v5

    sget-object v8, Len6;->a:[I

    invoke-virtual {v5}, Ljava/lang/Enum;->ordinal()I

    move-result v5

    aget v5, v8, v5

    sget-object v8, Ljm6;->F:Ljm6;

    sget-object v9, Ljm6;->E:Ljm6;

    if-ne v5, v3, :cond_6

    invoke-virtual {v0}, Ljn6;->H1()Z

    move-result v5

    if-nez v5, :cond_5

    move-object v5, v9

    goto :goto_0

    :cond_5
    move-object v5, v8

    goto :goto_0

    :cond_6
    invoke-virtual {v4}, Lkm6;->p()Ljm6;

    move-result-object v5

    :goto_0
    invoke-virtual {v4, v5}, Lkm6;->r(Ljm6;)V

    if-ne v2, v6, :cond_7

    if-ne v5, v8, :cond_7

    invoke-virtual {v1}, Lfud;->a()V

    invoke-virtual {v4, v3}, Lkm6;->s(Z)V

    :cond_7
    if-ne v2, v7, :cond_38

    if-ne v5, v9, :cond_8

    invoke-virtual {v1}, Lfud;->d()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    const/16 v6, 0xc

    invoke-static/range {v0 .. v6}, Ljn6;->z1(Ljn6;Lfud;JJI)V

    return-void

    :cond_8
    invoke-virtual {v4}, Lkm6;->q()Z

    move-result v2

    if-eqz v2, :cond_38

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v1, v1, v2, v3}, Ljn6;->G1(Lfud;Lfud;J)V

    invoke-virtual {v0, v2, v3, v1}, Ljn6;->F1(JLfud;)V

    invoke-virtual {v1}, Lfud;->d()J

    move-result-wide v1

    iget-object v3, v0, Ljn6;->e0:Lnm6;

    if-nez v3, :cond_9

    new-instance v3, Lnm6;

    invoke-direct {v3}, Lnm6;-><init>()V

    iput-object v3, v0, Ljn6;->e0:Lnm6;

    :cond_9
    invoke-virtual {v3, v1, v2}, Lnm6;->q(J)V

    iput-object v3, v0, Ljn6;->h0:Litk;

    return-void

    :cond_a
    instance-of v5, v4, Lmm6;

    sget-object v9, Laud;->G:Laud;

    if-eqz v5, :cond_22

    check-cast v4, Lmm6;

    if-ne v2, v6, :cond_b

    goto/16 :goto_12

    :cond_b
    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v5, v1

    check-cast v5, Ljava/util/Collection;

    invoke-interface {v5}, Ljava/util/Collection;->size()I

    move-result v6

    move v11, v8

    :goto_1
    if-ge v11, v6, :cond_d

    invoke-interface {v1, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    move-object v13, v12

    check-cast v13, Lfud;

    invoke-virtual {v13}, Lfud;->d()J

    move-result-wide v13

    move/from16 p1, v11

    invoke-virtual {v4}, Lmm6;->q()J

    move-result-wide v10

    invoke-static {v13, v14, v10, v11}, Leij;->o(JJ)Z

    move-result v10

    if-eqz v10, :cond_c

    goto :goto_2

    :cond_c
    add-int/lit8 v11, p1, 0x1

    goto :goto_1

    :cond_d
    const/4 v12, 0x0

    :goto_2
    check-cast v12, Lfud;

    if-nez v12, :cond_11

    invoke-interface {v5}, Ljava/util/Collection;->size()I

    move-result v6

    move v10, v8

    :goto_3
    if-ge v10, v6, :cond_f

    invoke-interface {v1, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    move-object v12, v11

    check-cast v12, Lfud;

    invoke-virtual {v12}, Lfud;->f()Z

    move-result v12

    if-eqz v12, :cond_e

    goto :goto_4

    :cond_e
    add-int/lit8 v10, v10, 0x1

    goto :goto_3

    :cond_f
    const/4 v11, 0x0

    :goto_4
    move-object v12, v11

    check-cast v12, Lfud;

    if-nez v12, :cond_10

    invoke-virtual {v0}, Ljn6;->x1()V

    return-void

    :cond_10
    invoke-virtual {v12}, Lfud;->d()J

    move-result-wide v10

    invoke-virtual {v4, v10, v11}, Lmm6;->t(J)V

    :cond_11
    const-string v6, "AwaitTouchSlop.touchSlopDetector was not initialized"

    const-string v10, "AwaitTouchSlop.initialDown was not initialized"

    if-ne v2, v7, :cond_1e

    invoke-virtual {v12}, Lfud;->l()Z

    move-result v7

    if-nez v7, :cond_1b

    invoke-static {v12}, Lnhl;->f(Lfud;)Z

    move-result v7

    if-eqz v7, :cond_15

    invoke-interface {v5}, Ljava/util/Collection;->size()I

    move-result v3

    move v5, v8

    :goto_5
    if-ge v5, v3, :cond_13

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    move-object v11, v7

    check-cast v11, Lfud;

    invoke-virtual {v11}, Lfud;->f()Z

    move-result v11

    if-eqz v11, :cond_12

    goto :goto_6

    :cond_12
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    :cond_13
    const/4 v7, 0x0

    :goto_6
    check-cast v7, Lfud;

    if-nez v7, :cond_14

    invoke-virtual {v0}, Ljn6;->x1()V

    goto/16 :goto_8

    :cond_14
    invoke-virtual {v7}, Lfud;->d()J

    move-result-wide v13

    invoke-virtual {v4, v13, v14}, Lmm6;->t(J)V

    goto/16 :goto_8

    :cond_15
    sget-object v1, Llx4;->u:Lmmh;

    invoke-static {v0, v1}, Lkvl;->m(Ldx4;Laje;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lspj;

    invoke-virtual {v12}, Lfud;->j()I

    move-result v5

    invoke-static {v1, v5}, Ldn6;->h(Lspj;I)F

    move-result v1

    iget-object v5, v0, Ljn6;->k0:Lgu8;

    if-eqz v5, :cond_1a

    invoke-static {v12}, Lnhl;->o(Lfud;)J

    move-result-wide v13

    invoke-static {v5, v13, v14, v1}, Lgu8;->u(Lgu8;JF)J

    move-result-wide v13

    const-wide v15, 0x7fffffff7fffffffL

    and-long/2addr v15, v13

    const-wide v17, 0x7fc000007fc00000L    # 2.247117487993712E307

    cmp-long v1, v15, v17

    if-eqz v1, :cond_19

    invoke-virtual {v0, v12}, Ljn6;->h0(Lfud;)Z

    move-result v1

    invoke-static {v0}, Lvpl;->q(Ly56;)Lte8;

    move-result-object v5

    if-eqz v5, :cond_16

    invoke-interface {v5, v12}, Lte8;->h0(Lfud;)Z

    move-result v5

    if-ne v5, v3, :cond_16

    move v5, v3

    goto :goto_7

    :cond_16
    move v5, v8

    :goto_7
    if-nez v1, :cond_17

    if-eqz v5, :cond_17

    invoke-virtual {v4, v3}, Lmm6;->u(Z)V

    goto :goto_8

    :cond_17
    invoke-virtual {v12}, Lfud;->a()V

    invoke-virtual {v4}, Lmm6;->p()Lfud;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v0, v1, v12, v13, v14}, Ljn6;->G1(Lfud;Lfud;J)V

    invoke-virtual {v0, v13, v14, v12}, Ljn6;->F1(JLfud;)V

    invoke-virtual {v12}, Lfud;->d()J

    move-result-wide v13

    iget-object v1, v0, Ljn6;->e0:Lnm6;

    if-nez v1, :cond_18

    new-instance v1, Lnm6;

    invoke-direct {v1}, Lnm6;-><init>()V

    iput-object v1, v0, Ljn6;->e0:Lnm6;

    :cond_18
    invoke-virtual {v1, v13, v14}, Lnm6;->q(J)V

    iput-object v1, v0, Ljn6;->h0:Litk;

    goto :goto_8

    :cond_19
    invoke-virtual {v4, v3}, Lmm6;->u(Z)V

    goto :goto_8

    :cond_1a
    const-string v0, "Touch slop detector not initialized."

    invoke-static {v0}, Lla7;->q(Ljava/lang/String;)V

    return-void

    :cond_1b
    invoke-virtual {v4}, Lmm6;->p()Lfud;

    move-result-object v1

    if-eqz v1, :cond_1d

    invoke-virtual {v4}, Lmm6;->q()J

    move-result-wide v13

    iget-object v3, v0, Ljn6;->k0:Lgu8;

    if-eqz v3, :cond_1c

    invoke-virtual {v0, v1, v13, v14, v3}, Ljn6;->y1(Lfud;JLgu8;)V

    goto :goto_8

    :cond_1c
    invoke-static {v6}, Lla7;->q(Ljava/lang/String;)V

    return-void

    :cond_1d
    invoke-static {v10}, Lla7;->q(Ljava/lang/String;)V

    return-void

    :cond_1e
    :goto_8
    if-ne v2, v9, :cond_38

    invoke-virtual {v4}, Lmm6;->r()Z

    move-result v1

    if-eqz v1, :cond_38

    invoke-virtual {v12}, Lfud;->l()Z

    move-result v1

    if-eqz v1, :cond_21

    invoke-virtual {v4}, Lmm6;->p()Lfud;

    move-result-object v1

    if-eqz v1, :cond_20

    invoke-virtual {v4}, Lmm6;->q()J

    move-result-wide v2

    iget-object v4, v0, Ljn6;->k0:Lgu8;

    if-eqz v4, :cond_1f

    invoke-virtual {v0, v1, v2, v3, v4}, Ljn6;->y1(Lfud;JLgu8;)V

    return-void

    :cond_1f
    invoke-static {v6}, Lla7;->q(Ljava/lang/String;)V

    return-void

    :cond_20
    invoke-static {v10}, Lla7;->q(Ljava/lang/String;)V

    return-void

    :cond_21
    invoke-virtual {v4, v8}, Lmm6;->u(Z)V

    return-void

    :cond_22
    instance-of v5, v4, Llm6;

    if-eqz v5, :cond_2a

    check-cast v4, Llm6;

    if-eq v2, v9, :cond_23

    goto/16 :goto_12

    :cond_23
    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v2, v1

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->size()I

    move-result v5

    move v6, v8

    :goto_9
    if-ge v6, v5, :cond_25

    invoke-interface {v1, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lfud;

    invoke-virtual {v7}, Lfud;->l()Z

    move-result v7

    if-eqz v7, :cond_24

    move v3, v8

    goto :goto_a

    :cond_24
    add-int/lit8 v6, v6, 0x1

    goto :goto_9

    :cond_25
    :goto_a
    invoke-interface {v2}, Ljava/util/Collection;->size()I

    move-result v2

    :goto_b
    if-ge v8, v2, :cond_29

    invoke-interface {v1, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lfud;

    invoke-virtual {v5}, Lfud;->f()Z

    move-result v5

    if-eqz v5, :cond_28

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_26

    goto :goto_c

    :cond_26
    if-eqz v3, :cond_38

    invoke-static {v1}, Lun4;->u0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lfud;

    invoke-virtual {v1}, Lfud;->e()J

    move-result-wide v1

    invoke-virtual {v4}, Llm6;->p()Lfud;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v3}, Lfud;->e()J

    move-result-wide v5

    invoke-static {v1, v2, v5, v6}, Lmwc;->h(JJ)J

    move-result-wide v1

    move-object v6, v4

    move-wide v4, v1

    invoke-virtual {v6}, Llm6;->p()Lfud;

    move-result-object v1

    if-eqz v1, :cond_27

    invoke-virtual {v6}, Llm6;->q()J

    move-result-wide v2

    const/16 v6, 0x8

    invoke-static/range {v0 .. v6}, Ljn6;->z1(Ljn6;Lfud;JJI)V

    return-void

    :cond_27
    const-string v0, "AwaitGesturePickup.initialDown was not initialized."

    invoke-static {v0}, Lla7;->q(Ljava/lang/String;)V

    return-void

    :cond_28
    move-object v6, v4

    add-int/lit8 v8, v8, 0x1

    goto :goto_b

    :cond_29
    :goto_c
    invoke-virtual {v0}, Ljn6;->x1()V

    return-void

    :cond_2a
    instance-of v3, v4, Lnm6;

    if-eqz v3, :cond_36

    check-cast v4, Lnm6;

    if-eq v2, v7, :cond_2b

    goto/16 :goto_12

    :cond_2b
    invoke-virtual {v4}, Lnm6;->p()J

    move-result-wide v2

    iget-object v5, v1, Lztd;->a:Ljava/util/List;

    move-object v6, v5

    check-cast v6, Ljava/util/Collection;

    invoke-interface {v6}, Ljava/util/Collection;->size()I

    move-result v6

    move v7, v8

    :goto_d
    if-ge v7, v6, :cond_2d

    invoke-interface {v5, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    move-object v10, v9

    check-cast v10, Lfud;

    invoke-virtual {v10}, Lfud;->d()J

    move-result-wide v10

    invoke-static {v10, v11, v2, v3}, Leij;->o(JJ)Z

    move-result v10

    if-eqz v10, :cond_2c

    goto :goto_e

    :cond_2c
    add-int/lit8 v7, v7, 0x1

    goto :goto_d

    :cond_2d
    const/4 v9, 0x0

    :goto_e
    check-cast v9, Lfud;

    if-nez v9, :cond_2e

    goto/16 :goto_12

    :cond_2e
    invoke-static {v9}, Lnhl;->f(Lfud;)Z

    move-result v2

    sget-object v3, Lom6;->a:Lom6;

    if-eqz v2, :cond_33

    iget-object v1, v1, Lztd;->a:Ljava/util/List;

    move-object v2, v1

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->size()I

    move-result v2

    move v5, v8

    :goto_f
    if-ge v5, v2, :cond_30

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v7, v6

    check-cast v7, Lfud;

    invoke-virtual {v7}, Lfud;->f()Z

    move-result v7

    if-eqz v7, :cond_2f

    move-object v10, v6

    goto :goto_10

    :cond_2f
    add-int/lit8 v5, v5, 0x1

    goto :goto_f

    :cond_30
    const/4 v10, 0x0

    :goto_10
    check-cast v10, Lfud;

    if-nez v10, :cond_32

    invoke-virtual {v9}, Lfud;->l()Z

    move-result v1

    if-nez v1, :cond_31

    invoke-static {v9}, Lnhl;->f(Lfud;)Z

    move-result v1

    if-eqz v1, :cond_31

    invoke-virtual {v0}, Ljn6;->E1()Lsaf;

    move-result-object v1

    invoke-static {v1, v9}, Lqjl;->f(Lsaf;Lfud;)V

    sget-object v1, Llx4;->u:Lmmh;

    invoke-static {v0, v1}, Lkvl;->m(Ldx4;Laje;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lspj;

    invoke-interface {v1}, Lspj;->e()F

    move-result v1

    invoke-virtual {v0}, Ljn6;->E1()Lsaf;

    move-result-object v2

    invoke-static {v1, v1}, Lnjl;->e(FF)J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lsaf;->k(J)J

    move-result-wide v1

    invoke-virtual {v0}, Ljn6;->E1()Lsaf;

    move-result-object v3

    invoke-virtual {v3}, Lsaf;->q()V

    invoke-virtual {v0}, Ljn6;->D1()Llq2;

    move-result-object v3

    new-instance v4, Lrm6;

    invoke-static {v1, v2}, Leo6;->c(J)J

    move-result-wide v1

    invoke-direct {v4, v1, v2, v8}, Lrm6;-><init>(JZ)V

    invoke-interface {v3, v4}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    iput-boolean v8, v0, Ljn6;->c0:Z

    goto :goto_11

    :cond_31
    invoke-virtual {v0}, Ljn6;->D1()Llq2;

    move-result-object v1

    invoke-interface {v1, v3}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_11
    invoke-virtual {v0}, Ljn6;->x1()V

    return-void

    :cond_32
    invoke-virtual {v10}, Lfud;->d()J

    move-result-wide v0

    invoke-virtual {v4, v0, v1}, Lnm6;->q(J)V

    return-void

    :cond_33
    invoke-virtual {v9}, Lfud;->l()Z

    move-result v1

    if-eqz v1, :cond_34

    invoke-virtual {v0}, Ljn6;->D1()Llq2;

    move-result-object v0

    invoke-interface {v0, v3}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_34
    invoke-static {v9}, Lnhl;->o(Lfud;)J

    move-result-wide v1

    invoke-static {v1, v2}, Lmwc;->d(J)F

    move-result v1

    const/4 v2, 0x0

    cmpg-float v1, v1, v2

    if-nez v1, :cond_35

    goto :goto_12

    :cond_35
    invoke-static {v9}, Lnhl;->n(Lfud;)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2, v9}, Ljn6;->F1(JLfud;)V

    invoke-virtual {v9}, Lfud;->a()V

    return-void

    :cond_36
    invoke-static {}, Lla7;->d()V

    return-void

    :cond_37
    const-string v0, "currentDragState should not be null"

    invoke-static {v0}, Lla7;->q(Ljava/lang/String;)V

    :cond_38
    :goto_12
    return-void
.end method

.method public abstract C1(Lrm6;)V
.end method

.method public final D1()Llq2;
    .locals 0

    iget-object p0, p0, Ljn6;->Z:Lq52;

    if-eqz p0, :cond_0

    return-object p0

    :cond_0
    const-string p0, "Events channel not initialized."

    invoke-static {p0}, Lla7;->q(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0
.end method

.method public final E1()Lsaf;
    .locals 0

    iget-object p0, p0, Ljn6;->i0:Lsaf;

    if-eqz p0, :cond_0

    return-object p0

    :cond_0
    const-string p0, "Velocity Tracker not initialized."

    invoke-static {p0}, Lla7;->q(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0
.end method

.method public final F1(JLfud;)V
    .locals 6

    iget-object v0, p0, Lnac;->E:Lnac;

    invoke-static {v0}, Lgcb;->T(Lv56;)Lypc;

    move-result-object v0

    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Lypc;->p(J)J

    move-result-wide v0

    iget-wide v2, p0, Ljn6;->j0:J

    const-wide v4, 0x7fc000007fc00000L    # 2.247117487993712E307

    invoke-static {v2, v3, v4, v5}, Lmwc;->c(JJ)Z

    move-result v2

    if-nez v2, :cond_0

    iget-wide v2, p0, Ljn6;->j0:J

    invoke-static {v0, v1, v2, v3}, Lmwc;->c(JJ)Z

    move-result v2

    if-nez v2, :cond_0

    iget-wide v2, p0, Ljn6;->j0:J

    invoke-static {v0, v1, v2, v3}, Lmwc;->h(JJ)J

    move-result-wide v2

    iget-wide v4, p0, Ljn6;->m0:J

    invoke-static {v4, v5, v2, v3}, Lmwc;->i(JJ)J

    move-result-wide v2

    iput-wide v2, p0, Ljn6;->m0:J

    :cond_0
    iput-wide v0, p0, Ljn6;->j0:J

    invoke-virtual {p0}, Ljn6;->E1()Lsaf;

    move-result-object v0

    iget-wide v1, p0, Ljn6;->m0:J

    invoke-static {v0, p3, v1, v2}, Lqjl;->g(Lsaf;Lfud;J)V

    invoke-virtual {p0}, Ljn6;->D1()Llq2;

    move-result-object p0

    new-instance p3, Lpm6;

    const/4 v0, 0x0

    invoke-direct {p3, p1, p2, v0}, Lpm6;-><init>(JZ)V

    invoke-interface {p0, p3}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public final G1(Lfud;Lfud;J)V
    .locals 3

    iget-object v0, p0, Ljn6;->i0:Lsaf;

    if-nez v0, :cond_0

    new-instance v0, Lsaf;

    const/16 v1, 0xd

    invoke-direct {v0, v1}, Lsaf;-><init>(I)V

    iput-object v0, p0, Ljn6;->i0:Lsaf;

    :cond_0
    invoke-virtual {p0}, Ljn6;->E1()Lsaf;

    move-result-object v0

    invoke-static {v0, p1}, Lqjl;->f(Lsaf;Lfud;)V

    invoke-virtual {p2}, Lfud;->e()J

    move-result-wide v0

    invoke-static {v0, v1, p3, p4}, Lmwc;->h(JJ)J

    move-result-wide p2

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Ljn6;->m0:J

    iget-object p4, p0, Ljn6;->V:Lna8;

    invoke-virtual {p1}, Lfud;->j()I

    move-result p1

    invoke-static {p1}, Lqud;->a(I)Lqud;

    move-result-object p1

    invoke-interface {p4, p1}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-boolean p1, p0, Ljn6;->b0:Z

    if-nez p1, :cond_2

    iget-object p1, p0, Ljn6;->Z:Lq52;

    if-nez p1, :cond_1

    const p1, 0x7fffffff

    const/4 p4, 0x6

    const/4 v2, 0x0

    invoke-static {p1, p4, v2}, Lgcb;->a(IILh52;)Lq52;

    move-result-object p1

    iput-object p1, p0, Ljn6;->Z:Lq52;

    :cond_1
    invoke-virtual {p0}, Ljn6;->I1()V

    :cond_2
    invoke-static {p0}, Lgcb;->T(Lv56;)Lypc;

    move-result-object p1

    invoke-virtual {p1, v0, v1}, Lypc;->p(J)J

    move-result-wide v0

    iput-wide v0, p0, Ljn6;->j0:J

    invoke-virtual {p0}, Ljn6;->D1()Llq2;

    move-result-object p0

    new-instance p1, Lqm6;

    invoke-direct {p1, p2, p3}, Lqm6;-><init>(J)V

    invoke-interface {p0, p1}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    return-void
.end method

.method public final H(Ljf9;)Z
    .locals 0

    invoke-static {p1}, Lfo5;->j(Ljf9;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-boolean p0, p0, Ljn6;->W:Z

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public abstract H1()Z
.end method

.method public final I1()V
    .locals 3

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljn6;->b0:Z

    iget-object v0, p0, Ljn6;->Z:Lq52;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const v0, 0x7fffffff

    const/4 v2, 0x6

    invoke-static {v0, v2, v1}, Lgcb;->a(IILh52;)Lq52;

    move-result-object v0

    iput-object v0, p0, Ljn6;->Z:Lq52;

    :cond_0
    invoke-virtual {p0}, Lnac;->d1()Lxb5;

    move-result-object v0

    new-instance v2, Lin6;

    invoke-direct {v2, p0, v1}, Lin6;-><init>(Ljn6;Le85;)V

    const/4 p0, 0x3

    invoke-static {v0, v1, v1, v2, p0}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    return-void
.end method

.method public final J1(Lna8;ZLifc;Lh6d;Z)V
    .locals 2

    iput-object p1, p0, Ljn6;->V:Lna8;

    iget-boolean p1, p0, Ljn6;->W:Z

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eq p1, p2, :cond_1

    iput-boolean p2, p0, Ljn6;->W:Z

    if-nez p2, :cond_0

    invoke-virtual {p0}, Ljn6;->v1()V

    iput-object v0, p0, Ljn6;->l0:Lqf9;

    :cond_0
    move p5, v1

    :cond_1
    iget-object p1, p0, Ljn6;->X:Lifc;

    invoke-static {p1, p3}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Ljn6;->v1()V

    iput-object p3, p0, Ljn6;->X:Lifc;

    :cond_2
    iget-object p1, p0, Ljn6;->U:Lh6d;

    if-eq p1, p4, :cond_3

    iput-object p4, p0, Ljn6;->U:Lh6d;

    goto :goto_0

    :cond_3
    move v1, p5

    :goto_0
    if-eqz v1, :cond_6

    iget-boolean p1, p0, Ljn6;->c0:Z

    if-eqz p1, :cond_5

    invoke-virtual {p0}, Ljn6;->x1()V

    iget-boolean p1, p0, Ljn6;->b0:Z

    if-eqz p1, :cond_4

    invoke-virtual {p0}, Ljn6;->D1()Llq2;

    move-result-object p1

    sget-object p2, Lom6;->a:Lom6;

    invoke-interface {p1, p2}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    iput-object v0, p0, Ljn6;->i0:Lsaf;

    :cond_5
    iget-object p0, p0, Ljn6;->l0:Lqf9;

    if-eqz p0, :cond_6

    invoke-virtual {p0}, Lqf9;->f()V

    :cond_6
    return-void
.end method

.method public final S()V
    .locals 2

    iget-boolean v0, p0, Ljn6;->c0:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Ljn6;->x1()V

    iget-boolean v0, p0, Ljn6;->b0:Z

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljn6;->D1()Llq2;

    move-result-object v0

    sget-object v1, Lom6;->a:Lom6;

    invoke-interface {v0, v1}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ljn6;->i0:Lsaf;

    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Ljn6;->c0:Z

    return-void
.end method

.method public final h0(Lfud;)Z
    .locals 8

    invoke-static {p1}, Lnhl;->d(Lfud;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean p0, p0, Ljn6;->W:Z

    return p0

    :cond_0
    invoke-static {p1}, Lnhl;->f(Lfud;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ljn6;->k0:Lgu8;

    if-nez v0, :cond_2

    new-instance v0, Lgu8;

    iget-object v2, p0, Ljn6;->U:Lh6d;

    const/4 v3, 0x2

    invoke-direct {v0, v2, v3}, Lgu8;-><init>(Lh6d;I)V

    iput-object v0, p0, Ljn6;->k0:Lgu8;

    :cond_2
    sget-object v0, Llx4;->u:Lmmh;

    invoke-static {p0, v0}, Lkvl;->m(Ldx4;Laje;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lspj;

    invoke-interface {v0}, Lspj;->f()F

    move-result v0

    invoke-static {p1}, Lnhl;->n(Lfud;)J

    move-result-wide v2

    iget-object p0, p0, Ljn6;->k0:Lgu8;

    if-eqz p0, :cond_4

    invoke-virtual {p0, v0, v2, v3, v1}, Lgu8;->t(FJZ)J

    move-result-wide v4

    const-wide v6, 0x7fc000007fc00000L    # 2.247117487993712E307

    invoke-static {v4, v5, v6, v7}, Lmwc;->c(JJ)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-virtual {p0, v2, v3}, Lgu8;->v(J)Z

    move-result p0

    if-eqz p0, :cond_3

    const/4 p0, 0x1

    return p0

    :cond_3
    :goto_0
    return v1

    :cond_4
    const-string p0, "Touch slop detector not initialized."

    invoke-static {p0}, Lla7;->q(Ljava/lang/String;)V

    return v1
.end method

.method public final i1()V
    .locals 2

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljn6;->b0:Z

    invoke-virtual {p0}, Ljn6;->v1()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Ljn6;->m0:J

    iget-object v0, p0, Ljn6;->Y:Lue8;

    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Ly56;->q1(Lv56;)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ljn6;->Y:Lue8;

    return-void
.end method

.method public final u0()V
    .locals 0

    iget-object p0, p0, Ljn6;->l0:Lqf9;

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lqf9;->f()V

    :cond_0
    return-void
.end method

.method public final v1()V
    .locals 3

    iget-object v0, p0, Ljn6;->a0:Lqn6;

    if-eqz v0, :cond_1

    iget-object v1, p0, Ljn6;->X:Lifc;

    if-eqz v1, :cond_0

    new-instance v2, Lpn6;

    invoke-direct {v2, v0}, Lpn6;-><init>(Lqn6;)V

    invoke-virtual {v1, v2}, Lifc;->b(Lem9;)Z

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ljn6;->a0:Lqn6;

    :cond_1
    return-void
.end method

.method public abstract w1(Lin6;Lin6;)Ljava/lang/Object;
.end method

.method public final x1()V
    .locals 2

    iget-object v0, p0, Ljn6;->d0:Lkm6;

    if-nez v0, :cond_0

    new-instance v0, Lkm6;

    invoke-direct {v0}, Lkm6;-><init>()V

    iput-object v0, p0, Ljn6;->d0:Lkm6;

    :cond_0
    sget-object v1, Ljm6;->G:Ljm6;

    invoke-virtual {v0, v1}, Lkm6;->r(Ljm6;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lkm6;->s(Z)V

    iput-object v0, p0, Ljn6;->h0:Litk;

    return-void
.end method

.method public final y1(Lfud;JLgu8;)V
    .locals 1

    iget-object v0, p0, Ljn6;->g0:Llm6;

    if-nez v0, :cond_0

    new-instance v0, Llm6;

    invoke-direct {v0}, Llm6;-><init>()V

    iput-object v0, p0, Ljn6;->g0:Llm6;

    :cond_0
    invoke-virtual {v0, p1}, Llm6;->r(Lfud;)V

    invoke-virtual {v0, p2, p3}, Llm6;->s(J)V

    invoke-static {p4}, Lgu8;->z(Lgu8;)V

    iput-object v0, p0, Ljn6;->h0:Litk;

    return-void
.end method
