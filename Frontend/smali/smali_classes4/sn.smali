.class public final Lsn;
.super Lfzh;
.source "SourceFile"

# interfaces
.implements Lbb8;


# instance fields
.field public final synthetic E:I

.field public F:I

.field public G:Ljava/lang/Object;

.field public H:Ljava/lang/Object;

.field public I:Ljava/lang/Object;

.field public final synthetic J:Ljava/lang/Object;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Object;Le85;I)V
    .locals 0

    .line 17
    iput p3, p0, Lsn;->E:I

    iput-object p1, p0, Lsn;->J:Ljava/lang/Object;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p2}, Lfzh;-><init>(ILe85;)V

    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V
    .locals 0

    .line 15
    iput p4, p0, Lsn;->E:I

    iput-object p1, p0, Lsn;->I:Ljava/lang/Object;

    iput-object p2, p0, Lsn;->J:Ljava/lang/Object;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lfzh;-><init>(ILe85;)V

    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V
    .locals 0

    .line 16
    iput p5, p0, Lsn;->E:I

    iput-object p1, p0, Lsn;->H:Ljava/lang/Object;

    iput-object p2, p0, Lsn;->I:Ljava/lang/Object;

    iput-object p3, p0, Lsn;->J:Ljava/lang/Object;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p4}, Lfzh;-><init>(ILe85;)V

    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V
    .locals 0

    iput p6, p0, Lsn;->E:I

    iput-object p1, p0, Lsn;->G:Ljava/lang/Object;

    iput-object p2, p0, Lsn;->H:Ljava/lang/Object;

    iput-object p3, p0, Lsn;->I:Ljava/lang/Object;

    iput-object p4, p0, Lsn;->J:Ljava/lang/Object;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p5}, Lfzh;-><init>(ILe85;)V

    return-void
.end method

.method private final A(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    iget v0, p0, Lsn;->F:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object v3, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v3, Ljava/util/Iterator;

    iget-object v4, p0, Lsn;->G:Ljava/lang/Object;

    check-cast v4, Lwg3;

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v1

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lsn;->J:Ljava/lang/Object;

    check-cast p1, Lwg3;

    iget-object v0, p1, Lwg3;->I1:Lb7f;

    iget-object v0, v0, Lb7f;->F:Ljava/lang/Object;

    check-cast v0, Lybh;

    invoke-virtual {v0}, Lybh;->iterator()Ljava/util/Iterator;

    move-result-object v0

    move-object v4, p1

    move-object v3, v0

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result p1

    if-eqz p1, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/anthropic/hermes/types/strings/ResearchTaskId;

    invoke-virtual {p1}, Lcom/anthropic/hermes/types/strings/ResearchTaskId;->unbox-impl()Ljava/lang/String;

    move-result-object v0

    iget-object p1, v4, Lwg3;->I1:Lb7f;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object p1, p1, Lb7f;->G:Ljava/lang/Object;

    check-cast p1, Lybh;

    invoke-static {v0}, Lcom/anthropic/hermes/types/strings/ResearchTaskId;->box-impl(Ljava/lang/String;)Lcom/anthropic/hermes/types/strings/ResearchTaskId;

    move-result-object v5

    invoke-virtual {p1, v5}, Lybh;->add(Ljava/lang/Object;)Z

    iget-object p1, v4, Lwg3;->k:Llu2;

    iget-object v5, v4, Lwg3;->d:Lnij;

    iget-object v5, v5, Lnij;->d:Ljava/lang/String;

    iget-object v6, v4, Lwg3;->P0:Ljava/lang/String;

    iput-object v4, p0, Lsn;->G:Ljava/lang/Object;

    iput-object v3, p0, Lsn;->H:Ljava/lang/Object;

    iput-object v0, p0, Lsn;->I:Ljava/lang/Object;

    iput v2, p0, Lsn;->F:I

    invoke-interface {p1, v5, v6, v0, p0}, Llu2;->g(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Le85;)Ljava/lang/Object;

    move-result-object p1

    sget-object v5, Lyb5;->E:Lyb5;

    if-ne p1, v5, :cond_2

    return-object v5

    :cond_2
    :goto_1
    check-cast p1, Lcom/anthropic/hermes/api/result/ApiResult;

    instance-of v5, p1, Lpg0;

    if-eqz v5, :cond_3

    move-object v6, p1

    check-cast v6, Lpg0;

    iget-object v6, v6, Lpg0;->b:Ljava/lang/Object;

    check-cast v6, Lx7j;

    iget-object v6, v4, Lwg3;->I1:Lb7f;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v6, v6, Lb7f;->F:Ljava/lang/Object;

    check-cast v6, Lybh;

    invoke-static {v0}, Lcom/anthropic/hermes/types/strings/ResearchTaskId;->box-impl(Ljava/lang/String;)Lcom/anthropic/hermes/types/strings/ResearchTaskId;

    move-result-object v7

    invoke-virtual {v6, v7}, Lybh;->remove(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_3
    instance-of v6, p1, Log0;

    if-eqz v6, :cond_6

    :goto_2
    if-nez v5, :cond_5

    instance-of v5, p1, Log0;

    if-eqz v5, :cond_4

    iget-object v5, v4, Lwg3;->I1:Lb7f;

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v5, v5, Lb7f;->G:Ljava/lang/Object;

    check-cast v5, Lybh;

    invoke-static {v0}, Lcom/anthropic/hermes/types/strings/ResearchTaskId;->box-impl(Ljava/lang/String;)Lcom/anthropic/hermes/types/strings/ResearchTaskId;

    move-result-object v0

    invoke-virtual {v5, v0}, Lybh;->remove(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_4
    invoke-static {}, Lla7;->d()V

    return-object v1

    :cond_5
    :goto_3
    iget-object v0, v4, Lwg3;->m0:Lq52;

    invoke-static {p1, v0}, Lcom/anthropic/hermes/ui/components/snackbar/a;->a(Lcom/anthropic/hermes/api/result/ApiResult;Llq2;)V

    goto/16 :goto_0

    :cond_6
    invoke-static {}, Lla7;->d()V

    return-object v1

    :cond_7
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final B(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6

    iget v0, p0, Lsn;->F:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v2, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v1

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast p1, Lcom/anthropic/hermes/bell/tts/i;

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object v3, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    new-instance v4, Lf18;

    const/4 v5, 0x0

    invoke-direct {v4, v5, v3}, Lf18;-><init>(ILjava/lang/Object;)V

    iput v2, p0, Lsn;->F:I

    invoke-virtual {p1, v0, v4, p0}, Lcom/anthropic/hermes/bell/tts/i;->h(Ljava/lang/String;Lf18;Lg85;)Ljava/lang/Object;

    move-result-object p1

    sget-object v0, Lyb5;->E:Lyb5;

    if-ne p1, v0, :cond_2

    return-object v0

    :cond_2
    :goto_0
    check-cast p1, Lcom/anthropic/hermes/analytics/events/ReadAloudEvents$ReadAloudOutcome;

    sget-object v0, Lcom/anthropic/hermes/analytics/events/ReadAloudEvents$ReadAloudOutcome;->RATE_LIMITED:Lcom/anthropic/hermes/analytics/events/ReadAloudEvents$ReadAloudOutcome;

    if-ne p1, v0, :cond_3

    iget-object p0, p0, Lsn;->J:Ljava/lang/Object;

    check-cast p0, Llq2;

    new-instance p1, Lm47;

    const v0, 0x7f1203f1

    const/4 v2, 0x6

    invoke-direct {p1, v0, v1, v1, v2}, Lm47;-><init>(ILp47;Lhc3;I)V

    invoke-interface {p0, p1}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final d(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5

    iget v0, p0, Lsn;->F:I

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v1, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast p1, Lab2;

    iget-object p1, p1, Lab2;->a:Lcom/anthropic/hermes/bell/tts/i;

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object v2, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    new-instance v3, Lf18;

    const/4 v4, 0x0

    invoke-direct {v3, v4, v2}, Lf18;-><init>(ILjava/lang/Object;)V

    iput v1, p0, Lsn;->F:I

    invoke-virtual {p1, v0, v3, p0}, Lcom/anthropic/hermes/bell/tts/i;->h(Ljava/lang/String;Lf18;Lg85;)Ljava/lang/Object;

    move-result-object p1

    sget-object v0, Lyb5;->E:Lyb5;

    if-ne p1, v0, :cond_2

    return-object v0

    :cond_2
    :goto_0
    check-cast p1, Lcom/anthropic/hermes/analytics/events/ReadAloudEvents$ReadAloudOutcome;

    sget-object v0, Lcom/anthropic/hermes/analytics/events/ReadAloudEvents$ReadAloudOutcome;->RATE_LIMITED:Lcom/anthropic/hermes/analytics/events/ReadAloudEvents$ReadAloudOutcome;

    if-ne p1, v0, :cond_3

    iget-object p0, p0, Lsn;->J:Ljava/lang/Object;

    check-cast p0, Lueb;

    invoke-virtual {p0}, Lueb;->a()Ljava/lang/Object;

    :cond_3
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final n(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Lq52;

    iget v1, p0, Lsn;->F:I

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_1

    if-ne v1, v3, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v2

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast p1, Lw18;

    new-instance v1, Loq;

    iget-object v4, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v4, Ljava/util/concurrent/atomic/AtomicReference;

    iget-object v5, p0, Lsn;->J:Ljava/lang/Object;

    check-cast v5, Luki;

    const/4 v6, 0x2

    invoke-direct {v1, v6, v4, v0, v5}, Loq;-><init>(ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    iput v3, p0, Lsn;->F:I

    invoke-virtual {p1, v1, p0}, Lw18;->a(Lc18;Le85;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_2

    return-object p1

    :cond_2
    :goto_0
    invoke-virtual {v0, v2}, Lq52;->n(Ljava/lang/Throwable;)Z

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final q(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    iget-object v0, p0, Lsn;->G:Ljava/lang/Object;

    check-cast v0, Lh73;

    iget v1, p0, Lsn;->F:I

    const/4 v2, 0x1

    sget-object v3, Lx7j;->a:Lx7j;

    if-eqz v1, :cond_1

    if-ne v1, v2, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object v3

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    invoke-static {v0}, Lrhl;->f(Lh73;)Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    invoke-interface {v0}, Lh73;->i()Li73;

    move-result-object v7

    if-nez v7, :cond_3

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    check-cast p1, Lx33;

    iget-object v4, p1, Lx33;->a:Ln73;

    iget-object p1, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v6, p1

    check-cast v6, Lh73;

    sget-object v8, Lcom/anthropic/hermes/analytics/events/ChatEvents$UploadSource;->SEND_RETRY:Lcom/anthropic/hermes/analytics/events/ChatEvents$UploadSource;

    iget-object p1, p0, Lsn;->J:Ljava/lang/Object;

    move-object v9, p1

    check-cast v9, Lfo;

    iput v2, p0, Lsn;->F:I

    move-object v10, p0

    invoke-interface/range {v4 .. v10}, Ln73;->i(Ljava/lang/String;Lh73;Li73;Lcom/anthropic/hermes/analytics/events/ChatEvents$UploadSource;Lbb8;Lfzh;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_4

    return-object p1

    :cond_4
    :goto_0
    return-object v3
.end method

.method private final s(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 18

    move-object/from16 v9, p0

    iget-object v0, v9, Lsn;->G:Ljava/lang/Object;

    check-cast v0, Lw63;

    iget v1, v9, Lsn;->F:I

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    if-ne v1, v2, :cond_0

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {v0}, Lla7;->k(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0

    :cond_1
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v0, Lw63;->q:Lj70;

    iget-object v1, v1, Lj70;->e:Ljava/lang/Object;

    check-cast v1, Lx33;

    iget-object v3, v9, Lsn;->H:Ljava/lang/Object;

    check-cast v3, Ljava/io/File;

    invoke-virtual {v0}, Lw63;->b0()Lc63;

    move-result-object v4

    iget-object v4, v4, Lc63;->b:Ljava/lang/String;

    iget-object v5, v9, Lsn;->I:Ljava/lang/Object;

    check-cast v5, Lcom/anthropic/hermes/analytics/events/ChatEvents$AttachmentSource;

    move-object v6, v4

    sget-object v4, Lcom/anthropic/hermes/analytics/events/ScreenSource;->CHAT_SCREEN:Lcom/anthropic/hermes/analytics/events/ScreenSource;

    new-instance v10, Lfo;

    iget-object v12, v0, Lw63;->r:Lq52;

    const/16 v16, 0x0

    const/16 v17, 0x2

    const/4 v11, 0x2

    const-class v13, Llq2;

    const-string v14, "send"

    const-string v15, "send(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;"

    invoke-direct/range {v10 .. v17}, Lfo;-><init>(ILjava/lang/Object;Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;II)V

    iget-object v7, v9, Lsn;->J:Ljava/lang/Object;

    check-cast v7, Lla8;

    iget-object v8, v9, Lsn;->I:Ljava/lang/Object;

    check-cast v8, Lcom/anthropic/hermes/analytics/events/ChatEvents$AttachmentSource;

    new-instance v11, Lh63;

    invoke-direct {v11, v0, v8, v2}, Lh63;-><init>(Lw63;Lcom/anthropic/hermes/analytics/events/ChatEvents$AttachmentSource;I)V

    iput v2, v9, Lsn;->F:I

    move-object v2, v6

    const/4 v6, 0x0

    move-object v0, v1

    move-object v1, v3

    move-object v3, v5

    move-object v5, v10

    move-object v8, v11

    invoke-virtual/range {v0 .. v9}, Lx33;->b(Ljava/io/File;Ljava/lang/String;Lcom/anthropic/hermes/analytics/events/ChatEvents$AttachmentSource;Lcom/anthropic/hermes/analytics/events/ScreenSource;Lbb8;Lg43;Lla8;Lh63;Lg85;)Ljava/lang/Object;

    move-result-object v0

    sget-object v1, Lyb5;->E:Lyb5;

    if-ne v0, v1, :cond_2

    return-object v1

    :cond_2
    :goto_0
    sget-object v0, Lx7j;->a:Lx7j;

    return-object v0
.end method

.method private final t(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    iget v0, p0, Lsn;->F:I

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v1, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast p1, Lra3;

    iget-object p1, p1, Lra3;->i:Lcti;

    iget-object p1, p1, Lcti;->A:Lit4;

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object v2, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    iget-object v3, p0, Lsn;->J:Ljava/lang/Object;

    check-cast v3, Ldnb;

    iput v1, p0, Lsn;->F:I

    invoke-virtual {p1, v0, v2, v3, p0}, Lit4;->p(Ljava/lang/String;Ljava/lang/String;Ldnb;Lfzh;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_2

    return-object p1

    :cond_2
    :goto_0
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final u(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    iget v0, p0, Lsn;->F:I

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v1, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast p1, Lra3;

    iget-object p1, p1, Lra3;->i:Lcti;

    iget-object p1, p1, Lcti;->A:Lit4;

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object v2, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Lcom/anthropic/hermes/api/mcp/McpTool;

    iget-object v3, p0, Lsn;->J:Ljava/lang/Object;

    check-cast v3, Ldnb;

    iput v1, p0, Lsn;->F:I

    invoke-virtual {p1, v0, v2, v3, p0}, Lit4;->q(Ljava/lang/String;Lcom/anthropic/hermes/api/mcp/McpTool;Ldnb;Lfzh;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_2

    return-object p1

    :cond_2
    :goto_0
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final v(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    iget-object v0, p0, Lsn;->J:Ljava/lang/Object;

    check-cast v0, Lwg3;

    iget-object v1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lxb5;

    iget v2, p0, Lsn;->F:I

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x1

    sget-object v6, Lyb5;->E:Lyb5;

    if-eqz v2, :cond_2

    if-eq v2, v5, :cond_1

    if-ne v2, v4, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto/16 :goto_7

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v3

    :cond_1
    :try_start_0
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/util/concurrent/CancellationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_5

    :catch_0
    move-exception p1

    goto :goto_0

    :catch_1
    move-exception p0

    goto/16 :goto_8

    :cond_2
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    :try_start_1
    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    check-cast p1, Lbb8;

    iget-object v2, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Lhe3;

    iget-object v2, v2, Lhe3;->a:Lcid;

    iput-object v1, p0, Lsn;->G:Ljava/lang/Object;

    iput v5, p0, Lsn;->F:I

    invoke-interface {p1, v2, p0}, Lbb8;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1
    :try_end_1
    .catch Ljava/util/concurrent/CancellationException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    if-ne p1, v6, :cond_7

    goto/16 :goto_6

    :goto_0
    iget-object v2, v0, Lwg3;->z0:Lydd;

    invoke-virtual {v2}, Lydd;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lje3;

    instance-of v5, v2, Lie3;

    if-eqz v5, :cond_3

    check-cast v2, Lie3;

    goto :goto_1

    :cond_3
    move-object v2, v3

    :goto_1
    if-nez v2, :cond_4

    goto :goto_2

    :cond_4
    new-instance v5, Lhe3;

    invoke-virtual {v2}, Lie3;->a()Lcid;

    move-result-object v2

    invoke-direct {v5, v2}, Lhe3;-><init>(Lcid;)V

    iget-object v2, v0, Lwg3;->z0:Lydd;

    invoke-virtual {v2, v5}, Lydd;->setValue(Ljava/lang/Object;)V

    :goto_2
    sget-object v2, Leva;->a:Ldva;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {}, Ldva;->b()Z

    move-result v2

    if-nez v2, :cond_5

    goto :goto_5

    :cond_5
    invoke-static {v1}, Ls3j;->K(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ldva;->b:Ljava/util/concurrent/CopyOnWriteArrayList;

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    move-object v8, v7

    check-cast v8, Leva;

    check-cast v8, Lt40;

    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v5, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_6
    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_7

    sget-object v2, Leva;->a:Ldva;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    sget-object v2, Lp2f;->a:Lq2f;

    invoke-virtual {v2, p1}, Lq2f;->b(Ljava/lang/Class;)Lc0a;

    move-result-object p1

    invoke-interface {p1}, Lc0a;->f()Ljava/lang/String;

    move-result-object p1

    const-string v2, "MCP completion auth did not complete: "

    invoke-static {v2, p1}, Lc40;->j(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_4
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Leva;

    check-cast v5, Lt40;

    sget-object v7, Lxua;->I:Lxua;

    invoke-virtual {v5, v7, v1, p1}, Lt40;->b(Lxua;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    :cond_7
    :goto_5
    iput-object v3, p0, Lsn;->G:Ljava/lang/Object;

    iput v4, p0, Lsn;->F:I

    invoke-static {v0, p0}, Lwg3;->w0(Lwg3;Lg85;)Ljava/lang/Object;

    move-result-object p0

    if-ne p0, v6, :cond_8

    :goto_6
    return-object v6

    :cond_8
    :goto_7
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :goto_8
    iget-object p1, v0, Lwg3;->z0:Lydd;

    invoke-virtual {p1}, Lydd;->getValue()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lje3;

    instance-of v1, p1, Lie3;

    if-eqz v1, :cond_9

    move-object v3, p1

    check-cast v3, Lie3;

    :cond_9
    if-nez v3, :cond_a

    goto :goto_9

    :cond_a
    new-instance p1, Lhe3;

    invoke-virtual {v3}, Lie3;->a()Lcid;

    move-result-object v1

    invoke-direct {p1, v1}, Lhe3;-><init>(Lcid;)V

    iget-object v0, v0, Lwg3;->z0:Lydd;

    invoke-virtual {v0, p1}, Lydd;->setValue(Ljava/lang/Object;)V

    :goto_9
    throw p0
.end method

.method private final x(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Lwg3;

    iget-object v0, p0, Lsn;->G:Ljava/lang/Object;

    move-object v2, v0

    check-cast v2, Ljava/lang/Exception;

    iget v0, p0, Lsn;->F:I

    const/4 v8, 0x0

    const/4 v9, 0x1

    if-eqz v0, :cond_1

    if-ne v0, v9, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v8

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, v3, Lwg3;->Y:Lmi6;

    invoke-interface {p1}, Lmi6;->a()Lqb5;

    move-result-object p1

    new-instance v1, Lnf;

    iget-object v0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Lned;

    iget-object v0, p0, Lsn;->J:Ljava/lang/Object;

    move-object v5, v0

    check-cast v5, Lcom/anthropic/hermes/mcpapps/transport/JsonRpcRequest;

    const/4 v6, 0x0

    const/16 v7, 0x9

    invoke-direct/range {v1 .. v7}, Lnf;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object v8, p0, Lsn;->G:Ljava/lang/Object;

    iput v9, p0, Lsn;->F:I

    invoke-static {p1, v1, p0}, Lxwf;->g0(Lob5;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_2

    return-object p1

    :cond_2
    :goto_0
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final y(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    iget-object v0, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v0, Lzpi;

    iget-object v1, p0, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lwg3;

    iget v2, p0, Lsn;->F:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eqz v2, :cond_1

    if-ne v2, v4, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v3

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, v1, Lwg3;->k:Llu2;

    iget-object v2, v1, Lwg3;->d:Lnij;

    iget-object v2, v2, Lnij;->d:Ljava/lang/String;

    iget-object v5, v1, Lwg3;->P0:Ljava/lang/String;

    new-instance v6, Lcom/anthropic/hermes/api/chat/RecordToolResultRequest;

    iget-object v7, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v7, Ljava/lang/String;

    new-instance v8, Lcom/anthropic/hermes/api/chat/tool/ToolResultText;

    check-cast v0, Lcom/anthropic/hermes/tool/model/ToolInvocationResult$Report;

    invoke-virtual {v0}, Lcom/anthropic/hermes/tool/model/ToolInvocationResult$Report;->getResponse()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x2

    invoke-direct {v8, v9, v3, v10, v3}, Lcom/anthropic/hermes/api/chat/tool/ToolResultText;-><init>(Ljava/lang/String;Ljava/lang/String;ILxz5;)V

    invoke-static {v8}, Looc;->F(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v8

    invoke-virtual {v0}, Lcom/anthropic/hermes/tool/model/ToolInvocationResult$Report;->getSuccess()Z

    move-result v0

    xor-int/2addr v0, v4

    invoke-direct {v6, v7, v8, v0, v3}, Lcom/anthropic/hermes/api/chat/RecordToolResultRequest;-><init>(Ljava/lang/String;Ljava/util/List;ZLxz5;)V

    iput v4, p0, Lsn;->F:I

    invoke-interface {p1, v2, v5, v6, p0}, Llu2;->s(Ljava/lang/String;Ljava/lang/String;Lcom/anthropic/hermes/api/chat/RecordToolResultRequest;Le85;)Ljava/lang/Object;

    move-result-object p1

    sget-object v0, Lyb5;->E:Lyb5;

    if-ne p1, v0, :cond_2

    return-object v0

    :cond_2
    :goto_0
    check-cast p1, Lcom/anthropic/hermes/api/result/ApiResult;

    iget-object p0, p0, Lsn;->J:Ljava/lang/Object;

    check-cast p0, Ljava/lang/String;

    instance-of v0, p1, Lpg0;

    if-nez v0, :cond_4

    instance-of v0, p1, Log0;

    if-eqz v0, :cond_3

    check-cast p1, Log0;

    new-instance v0, Lcom/anthropic/hermes/core/telemetry/SilentException;

    const-string v2, "Failed to send custom tool result for "

    invoke-static {v2, p0}, Lc40;->j(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1}, Lgpl;->k(Log0;)Ljava/lang/Throwable;

    move-result-object v2

    invoke-direct {v0, p0, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 p0, 0x0

    const/4 v2, 0x7

    invoke-static {v0, v3, p0, v3, v2}, Lcom/anthropic/hermes/core/telemetry/SilentException;->a(Lcom/anthropic/hermes/core/telemetry/SilentException;Lhwg;ZLjava/util/List;I)V

    iget-object p0, v1, Lwg3;->m0:Lq52;

    invoke-static {p1, p0}, Lcom/anthropic/hermes/ui/components/snackbar/a;->a(Lcom/anthropic/hermes/api/result/ApiResult;Llq2;)V

    goto :goto_1

    :cond_3
    invoke-static {}, Lla7;->d()V

    return-object v3

    :cond_4
    :goto_1
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method

.method private final z(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 12

    iget-object v0, p0, Lsn;->J:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Ljava/lang/String;

    iget-object v0, p0, Lsn;->G:Ljava/lang/Object;

    check-cast v0, Lwg3;

    iget-object v8, v0, Lwg3;->m0:Lq52;

    iget-object v1, v0, Lwg3;->P0:Ljava/lang/String;

    iget v2, p0, Lsn;->F:I

    const/4 v9, 0x0

    const/4 v10, 0x3

    const/4 v4, 0x2

    const/4 v5, 0x1

    sget-object v11, Lyb5;->E:Lyb5;

    if-eqz v2, :cond_3

    if-eq v2, v5, :cond_2

    if-eq v2, v4, :cond_1

    if-ne v2, v10, :cond_0

    goto :goto_0

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v9

    :cond_1
    :goto_0
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto/16 :goto_3

    :cond_2
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :cond_3
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, v0, Lwg3;->Q:Ly0c;

    iget-object v2, p0, Lsn;->H:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    iput v5, p0, Lsn;->F:I

    invoke-virtual {p1, v2, v1, p0}, Ly0c;->d(Ljava/lang/String;Ljava/lang/String;Lg85;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v11, :cond_4

    goto :goto_2

    :cond_4
    :goto_1
    check-cast p1, Luk6;

    if-eqz p1, :cond_5

    iget-object v0, v0, Lwg3;->R:Lxk6;

    iget-wide v6, p1, Luk6;->a:J

    new-instance p1, Lxhd;

    iget-object v2, p0, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadSource;

    invoke-direct {p1, v5, v2, v3, v1}, Lxhd;-><init>(ZLcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadSource;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, v0, Lxk6;->c:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance p1, Lm47;

    sget-object v0, Lp47;->G:Lp47;

    const/4 v1, 0x4

    const v2, 0x7f120ba1

    invoke-direct {p1, v2, v0, v9, v1}, Lm47;-><init>(ILp47;Lhc3;I)V

    iput v4, p0, Lsn;->F:I

    invoke-interface {v8, p0, p1}, Lffg;->c(Le85;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-ne p0, v11, :cond_6

    goto :goto_2

    :cond_5
    iget-object p1, v0, Lwg3;->y:Lmu3;

    new-instance v1, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$FileDownloadResult;

    iget-object v0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v2, v0

    check-cast v2, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadSource;

    sget-object v4, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadOutcome;->ENQUEUE_FAILED:Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadOutcome;

    const/16 v6, 0x8

    const/4 v7, 0x0

    const/4 v5, 0x0

    invoke-direct/range {v1 .. v7}, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$FileDownloadResult;-><init>(Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadSource;Ljava/lang/String;Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadOutcome;Ljava/lang/String;ILxz5;)V

    sget-object v0, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$FileDownloadResult;->Companion:Le1c;

    invoke-virtual {v0}, Le1c;->serializer()Lkotlinx/serialization/KSerializer;

    move-result-object v0

    check-cast v0, Luig;

    invoke-interface {p1, v1, v0}, Lmu3;->f(Lcom/anthropic/hermes/analytics/events/AnalyticsEvent;Luig;)V

    new-instance p1, Lm47;

    const v0, 0x7f120ba0

    const/4 v1, 0x6

    invoke-direct {p1, v0, v9, v9, v1}, Lm47;-><init>(ILp47;Lhc3;I)V

    iput v10, p0, Lsn;->F:I

    invoke-interface {v8, p0, p1}, Lffg;->c(Le85;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-ne p0, v11, :cond_6

    :goto_2
    return-object v11

    :cond_6
    :goto_3
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Le85;)Le85;
    .locals 10

    iget v0, p0, Lsn;->E:I

    iget-object v1, p0, Lsn;->J:Ljava/lang/Object;

    packed-switch v0, :pswitch_data_0

    new-instance v2, Lsn;

    iget-object v0, p0, Lsn;->H:Ljava/lang/Object;

    move-object v3, v0

    check-cast v3, Lw63;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v4, p0

    check-cast v4, Lf73;

    move-object v5, v1

    check-cast v5, Ljpf;

    const/16 v7, 0x1d

    move-object v6, p2

    invoke-direct/range {v2 .. v7}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v2, Lsn;->G:Ljava/lang/Object;

    return-object v2

    :pswitch_0
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lcom/anthropic/hermes/bell/tts/i;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/lang/String;

    move-object v7, v1

    check-cast v7, Llq2;

    const/16 v9, 0x1c

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_1
    move-object v8, p2

    new-instance p0, Lsn;

    check-cast v1, Lwg3;

    const/16 p1, 0x1b

    invoke-direct {p0, v1, v8, p1}, Lsn;-><init>(Ljava/lang/Object;Le85;I)V

    return-object p0

    :pswitch_2
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lwg3;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lcom/anthropic/hermes/analytics/events/MessageFileEvents$DownloadSource;

    move-object v7, v1

    check-cast v7, Ljava/lang/String;

    const/16 v9, 0x1a

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_3
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lwg3;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lzpi;

    move-object v7, v1

    check-cast v7, Ljava/lang/String;

    const/16 v9, 0x19

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_4
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p2, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p2

    check-cast v4, Lwg3;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, Lned;

    move-object v6, v1

    check-cast v6, Lcom/anthropic/hermes/mcpapps/transport/JsonRpcRequest;

    move-object v7, v8

    const/16 v8, 0x18

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v3, Lsn;->G:Ljava/lang/Object;

    return-object v3

    :pswitch_5
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p2, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p2

    check-cast v4, Lbb8;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, Lhe3;

    move-object v6, v1

    check-cast v6, Lwg3;

    move-object v7, v8

    const/16 v8, 0x17

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v3, Lsn;->G:Ljava/lang/Object;

    return-object v3

    :pswitch_6
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lra3;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lcom/anthropic/hermes/api/mcp/McpTool;

    move-object v7, v1

    check-cast v7, Ldnb;

    const/16 v9, 0x16

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_7
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lra3;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/lang/String;

    move-object v7, v1

    check-cast v7, Ldnb;

    const/16 v9, 0x15

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_8
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lw63;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/io/File;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lcom/anthropic/hermes/analytics/events/ChatEvents$AttachmentSource;

    move-object v7, v1

    check-cast v7, Lla8;

    const/16 v9, 0x14

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_9
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lh73;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Lx33;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/lang/String;

    move-object v7, v1

    check-cast v7, Lfo;

    const/16 v9, 0x13

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_a
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lw18;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Lq52;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/util/concurrent/atomic/AtomicReference;

    move-object v7, v1

    check-cast v7, Luki;

    const/16 v9, 0x12

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_b
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lab2;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ljava/lang/String;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/lang/String;

    move-object v7, v1

    check-cast v7, Lueb;

    const/16 v9, 0x11

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_c
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lo82;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Lpj5;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Landroid/app/Activity;

    move-object v7, v1

    check-cast v7, Li82;

    const/16 v9, 0x10

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_d
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Landroid/content/Context;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Ly0c;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/lang/String;

    move-object v7, v1

    check-cast v7, Ljava/lang/String;

    const/16 v9, 0xf

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_e
    move-object v8, p2

    new-instance p1, Lsn;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    check-cast p0, Lmu1;

    check-cast v1, Lhni;

    const/16 p2, 0xe

    invoke-direct {p1, p0, v1, v8, p2}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object p1

    :pswitch_f
    move-object v8, p2

    new-instance p0, Lsn;

    check-cast v1, Ldu1;

    const/16 p1, 0xd

    invoke-direct {p0, v1, v8, p1}, Lsn;-><init>(Ljava/lang/Object;Le85;I)V

    return-object p0

    :pswitch_10
    move-object v8, p2

    new-instance p1, Lsn;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    check-cast p0, Lbp1;

    check-cast v1, Ljava/lang/String;

    const/16 p2, 0xc

    invoke-direct {p1, p0, v1, v8, p2}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object p1

    :pswitch_11
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lun1;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Lsob;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Ljava/lang/Integer;

    move-object v7, v1

    check-cast v7, Lde;

    const/16 v9, 0xb

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_12
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p2, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p2

    check-cast v4, Landroid/media/AudioManager;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, La81;

    move-object v6, v1

    check-cast v6, Ljava/lang/Integer;

    move-object v7, v8

    const/16 v8, 0xa

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v3, Lsn;->G:Ljava/lang/Object;

    return-object v3

    :pswitch_13
    move-object v8, p2

    new-instance p0, Lsn;

    check-cast v1, Ll11;

    const/16 p1, 0x9

    invoke-direct {p0, v1, v8, p1}, Lsn;-><init>(Ljava/lang/Object;Le85;I)V

    return-object p0

    :pswitch_14
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lgx0;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, Lla8;

    move-object v6, v1

    check-cast v6, Lhx0;

    move-object v7, v8

    const/16 v8, 0x8

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_15
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Ldt0;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Liyf;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lla8;

    move-object v7, v1

    check-cast v7, Lvgc;

    const/4 v9, 0x7

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_16
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Landroid/app/Activity;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Lur0;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lxr0;

    move-object v7, v1

    check-cast v7, Lla8;

    const/4 v9, 0x6

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_17
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p2, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p2

    check-cast v4, Ltml;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    move-object v6, v1

    check-cast v6, Lco0;

    move-object v7, v8

    const/4 v8, 0x5

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v3, Lsn;->G:Ljava/lang/Object;

    return-object v3

    :pswitch_18
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p2, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p2

    check-cast v4, Llo0;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    move-object v6, v1

    check-cast v6, Lvgc;

    move-object v7, v8

    const/4 v8, 0x4

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v3, Lsn;->G:Ljava/lang/Object;

    return-object v3

    :pswitch_19
    move-object v8, p2

    new-instance p2, Lsn;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    check-cast p0, Llq2;

    check-cast v1, Lua0;

    const/4 v0, 0x3

    invoke-direct {p2, p0, v1, v8, v0}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, p2, Lsn;->H:Ljava/lang/Object;

    return-object p2

    :pswitch_1a
    move-object v8, p2

    new-instance p2, Lsn;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    check-cast p0, Llq2;

    check-cast v1, Lfb0;

    const/4 v0, 0x2

    invoke-direct {p2, p0, v1, v8, v0}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, p2, Lsn;->H:Ljava/lang/Object;

    return-object p2

    :pswitch_1b
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p2, p0, Lsn;->H:Ljava/lang/Object;

    move-object v4, p2

    check-cast v4, Lna8;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v5, p0

    check-cast v5, Le40;

    move-object v6, v1

    check-cast v6, Lsga;

    move-object v7, v8

    const/4 v8, 0x1

    invoke-direct/range {v3 .. v8}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput-object p1, v3, Lsn;->G:Ljava/lang/Object;

    return-object v3

    :pswitch_1c
    move-object v8, p2

    new-instance v3, Lsn;

    iget-object p1, p0, Lsn;->G:Ljava/lang/Object;

    move-object v4, p1

    check-cast v4, Lio;

    iget-object p1, p0, Lsn;->H:Ljava/lang/Object;

    move-object v5, p1

    check-cast v5, Landroid/net/Uri;

    iget-object p0, p0, Lsn;->I:Ljava/lang/Object;

    move-object v6, p0

    check-cast v6, Lfn;

    move-object v7, v1

    check-cast v7, Ljava/util/UUID;

    const/4 v9, 0x0

    invoke-direct/range {v3 .. v9}, Lsn;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    return-object v3

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
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

.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    iget v0, p0, Lsn;->E:I

    sget-object v1, Lyb5;->E:Lyb5;

    sget-object v2, Lx7j;->a:Lx7j;

    packed-switch v0, :pswitch_data_0

    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_0
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_1
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_2
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_3
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_4
    check-cast p1, Ljava/lang/Exception;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_5
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_6
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_7
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_8
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_9
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_a
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_b
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_c
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_d
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_e
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_f
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_10
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_11
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_12
    check-cast p1, Lq4e;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_13
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1

    :pswitch_14
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_15
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_16
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_17
    check-cast p1, Lq4e;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_18
    check-cast p1, Lp4e;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_19
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_1a
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :pswitch_1b
    check-cast p1, Lcsd;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1

    :pswitch_1c
    check-cast p1, Lxb5;

    check-cast p2, Le85;

    invoke-virtual {p0, p1, p2}, Lsn;->create(Ljava/lang/Object;Le85;)Le85;

    move-result-object p0

    check-cast p0, Lsn;

    invoke-virtual {p0, v2}, Lsn;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
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

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 27

    move-object/from16 v5, p0

    iget v0, v5, Lsn;->E:I

    const/16 v1, 0x8

    const/4 v2, 0x3

    const/4 v3, 0x4

    const/4 v4, 0x2

    const/4 v6, 0x0

    const-string v7, "call to \'resume\' before \'invoke\' with coroutine"

    const/4 v8, 0x1

    const/4 v9, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v0, Lxb5;

    sget-object v6, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_1

    if-ne v1, v8, :cond_0

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v0, p1

    goto :goto_0

    :cond_0
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v1, Lw63;

    iget-object v2, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Lf73;

    iput-object v9, v5, Lsn;->G:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    const-wide/16 v3, 0x1f4

    invoke-static/range {v0 .. v5}, Lcom/anthropic/hermes/chat/d;->h(Lxb5;Lw63;Lf73;JLg85;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v6, :cond_2

    move-object v9, v6

    goto :goto_1

    :cond_2
    :goto_0
    check-cast v0, Lcom/anthropic/hermes/chat/bottomsheet/ChatScreenModalBottomSheetDestination;

    if-eqz v0, :cond_3

    iget-object v1, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v1, Ljpf;

    new-instance v2, Lad3;

    invoke-direct {v2, v0, v8}, Lad3;-><init>(Lcom/anthropic/hermes/chat/bottomsheet/ChatScreenModalBottomSheetDestination;I)V

    new-instance v0, Lid3;

    const/16 v3, 0x13

    invoke-direct {v0, v3}, Lid3;-><init>(I)V

    iget-object v1, v1, Ljpf;->E:Ln36;

    invoke-virtual {v1, v2, v0}, Ln36;->f(Lna8;Lbb8;)V

    :cond_3
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_1
    return-object v9

    :pswitch_0
    invoke-direct/range {p0 .. p1}, Lsn;->B(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_1
    invoke-direct/range {p0 .. p1}, Lsn;->A(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_2
    invoke-direct/range {p0 .. p1}, Lsn;->z(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_3
    invoke-direct/range {p0 .. p1}, Lsn;->y(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_4
    invoke-direct/range {p0 .. p1}, Lsn;->x(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_5
    invoke-direct/range {p0 .. p1}, Lsn;->v(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_6
    invoke-direct/range {p0 .. p1}, Lsn;->u(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_7
    invoke-direct/range {p0 .. p1}, Lsn;->t(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_8
    invoke-direct/range {p0 .. p1}, Lsn;->s(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_9
    invoke-direct/range {p0 .. p1}, Lsn;->q(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_a
    invoke-direct/range {p0 .. p1}, Lsn;->n(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_b
    invoke-direct/range {p0 .. p1}, Lsn;->d(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :pswitch_c
    iget-object v0, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Lpj5;

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lo82;

    sget-object v2, Lyb5;->E:Lyb5;

    iget v3, v5, Lsn;->F:I

    if-eqz v3, :cond_5

    if-ne v3, v8, :cond_4

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v3, p1

    goto :goto_2

    :cond_4
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    goto/16 :goto_6

    :cond_5
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v3, v1, Lo82;->b:Lik5;

    iget-object v4, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v4, Landroid/app/Activity;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v3, v0, v4, v5}, Lik5;->d(Lpj5;Landroid/app/Activity;Lg85;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v2, :cond_6

    move-object v9, v2

    goto/16 :goto_6

    :cond_6
    :goto_2
    check-cast v3, Lck5;

    iget-object v2, v1, Lo82;->c:Ld82;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {v3}, Lp82;->a(Lck5;)Ldff;

    move-result-object v4

    iget-object v7, v2, Ld82;->c:Ljava/lang/Object;

    check-cast v7, Lmu3;

    new-instance v10, Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsPurchaseResolved;

    iget-object v2, v2, Ld82;->d:Ljava/lang/Enum;

    move-object v11, v2

    check-cast v11, Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsSurface;

    iget-object v12, v0, Lpj5;->a:Ljava/lang/String;

    iget v0, v0, Lpj5;->b:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    iget-object v14, v4, Ldff;->a:Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsPurchaseOutcome;

    iget-boolean v15, v4, Ldff;->b:Z

    sget-object v16, Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsResolvedVia;->IN_SESSION:Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsResolvedVia;

    iget-object v0, v4, Ldff;->e:Ljava/lang/Boolean;

    iget-object v2, v4, Ldff;->c:Lcom/anthropic/hermes/analytics/events/ProUpsellEvents$StoreViewPurchaseErrorKind;

    iget-object v4, v4, Ldff;->d:Ljava/lang/String;

    instance-of v8, v3, Lzj5;

    if-eqz v8, :cond_7

    move-object/from16 v17, v3

    check-cast v17, Lzj5;

    move-object/from16 v9, v17

    :cond_7
    if-eqz v9, :cond_8

    iget-object v9, v9, Lzj5;->b:Ljava/lang/Integer;

    move-object/from16 v21, v9

    goto :goto_3

    :cond_8
    const/16 v21, 0x0

    :goto_3
    invoke-interface {v3}, Lck5;->a()Ljava/lang/String;

    move-result-object v23

    const/16 v24, 0x880

    const/16 v25, 0x0

    const/16 v18, 0x0

    const/16 v22, 0x0

    move-object/from16 v17, v0

    move-object/from16 v19, v2

    move-object/from16 v20, v4

    invoke-direct/range {v10 .. v25}, Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsPurchaseResolved;-><init>(Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsSurface;Ljava/lang/String;Ljava/lang/Integer;Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsPurchaseOutcome;ZLcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsResolvedVia;Ljava/lang/Boolean;Ljava/lang/Integer;Lcom/anthropic/hermes/analytics/events/ProUpsellEvents$StoreViewPurchaseErrorKind;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;ILxz5;)V

    sget-object v0, Lcom/anthropic/hermes/analytics/events/UsageCreditsEvents$UsageCreditsPurchaseResolved;->Companion:Lcfj;

    invoke-virtual {v0}, Lcfj;->serializer()Lkotlinx/serialization/KSerializer;

    move-result-object v0

    check-cast v0, Luig;

    invoke-interface {v7, v10, v0}, Lmu3;->f(Lcom/anthropic/hermes/analytics/events/AnalyticsEvent;Luig;)V

    if-eqz v8, :cond_9

    new-instance v0, Lh82;

    check-cast v3, Lzj5;

    iget v2, v3, Lzj5;->a:I

    invoke-direct {v0, v2}, Lh82;-><init>(I)V

    goto :goto_5

    :cond_9
    sget-object v0, Lak5;->a:Lak5;

    invoke-virtual {v3, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    sget-object v0, Lk82;->a:Lk82;

    goto :goto_5

    :cond_a
    instance-of v0, v3, Lxj5;

    if-nez v0, :cond_f

    sget-object v0, Lbk5;->a:Lbk5;

    invoke-virtual {v3, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    goto :goto_4

    :cond_b
    instance-of v0, v3, Lyj5;

    if-eqz v0, :cond_c

    sget-object v0, Lg82;->a:Lg82;

    goto :goto_5

    :cond_c
    sget-object v0, Lwj5;->a:Lwj5;

    invoke-virtual {v3, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_d

    iget-object v0, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v0, Li82;

    const/16 v2, 0x1b

    invoke-static {v0, v6, v6, v2}, Li82;->a(Li82;IZI)Li82;

    move-result-object v0

    goto :goto_5

    :cond_d
    instance-of v0, v3, Lvj5;

    if-eqz v0, :cond_e

    sget-object v0, Ll82;->a:Ll82;

    goto :goto_5

    :cond_e
    invoke-static {}, Lla7;->d()V

    const/4 v9, 0x0

    goto :goto_6

    :cond_f
    :goto_4
    sget-object v0, Lf82;->a:Lf82;

    :goto_5
    invoke-virtual {v1, v0}, Lo82;->P(Ln82;)V

    sget-object v9, Lx7j;->a:Lx7j;

    :goto_6
    return-object v9

    :pswitch_d
    sget-object v0, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_11

    if-ne v1, v8, :cond_10

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v1, p1

    goto :goto_7

    :cond_10
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_9

    :cond_11
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    sget-object v1, Liqc;->F:Liqc;

    new-instance v9, Las1;

    iget-object v2, v5, Lsn;->H:Ljava/lang/Object;

    move-object v10, v2

    check-cast v10, Ly0c;

    iget-object v2, v5, Lsn;->I:Ljava/lang/Object;

    move-object v11, v2

    check-cast v11, Ljava/lang/String;

    iget-object v2, v5, Lsn;->J:Ljava/lang/Object;

    move-object v12, v2

    check-cast v12, Ljava/lang/String;

    const/4 v13, 0x0

    const/4 v14, 0x4

    invoke-direct/range {v9 .. v14}, Las1;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput v8, v5, Lsn;->F:I

    invoke-static {v1, v9, v5}, Lxwf;->g0(Lob5;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_12

    move-object v9, v0

    goto :goto_9

    :cond_12
    :goto_7
    check-cast v1, Luk6;

    if-eqz v1, :cond_13

    const v0, 0x7f120156

    goto :goto_8

    :cond_13
    const v0, 0x7f120154

    :goto_8
    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Landroid/content/Context;

    invoke-static {v1, v0, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    sget-object v9, Lx7j;->a:Lx7j;

    :goto_9
    return-object v9

    :pswitch_e
    sget-object v0, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_16

    if-eq v1, v8, :cond_15

    if-ne v1, v4, :cond_14

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_c

    :cond_14
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_d

    :cond_15
    iget-object v1, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    iget-object v2, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v2, Lmu1;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v3, v1

    move-object/from16 v1, p1

    goto :goto_a

    :cond_16
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v5, Lsn;->I:Ljava/lang/Object;

    move-object v2, v1

    check-cast v2, Lmu1;

    iget-object v1, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v1, Lhni;

    iget-object v3, v1, Lhni;->c:Ljava/lang/String;

    iget-object v6, v2, Lmu1;->d:Lvqi;

    iget-object v1, v1, Lhni;->a:Ljava/lang/String;

    iput-object v2, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v3, v5, Lsn;->H:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v6, v1, v5}, Lvqi;->c(Ljava/lang/String;Lg85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_17

    goto :goto_b

    :cond_17
    :goto_a
    check-cast v1, Ljava/lang/String;

    const/4 v6, 0x0

    iput-object v6, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v6, v5, Lsn;->H:Ljava/lang/Object;

    iput v4, v5, Lsn;->F:I

    invoke-static {v2, v3, v1, v5}, Lmu1;->a(Lmu1;Ljava/lang/String;Ljava/lang/String;Lg85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_18

    :goto_b
    move-object v9, v0

    goto :goto_d

    :cond_18
    :goto_c
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_d
    return-object v9

    :pswitch_f
    sget-object v0, Lx7j;->a:Lx7j;

    iget-object v6, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v6, Ldu1;

    sget-object v9, Lyb5;->E:Lyb5;

    iget v10, v5, Lsn;->F:I

    if-eqz v10, :cond_1b

    if-eq v10, v8, :cond_1a

    if-ne v10, v4, :cond_19

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto/16 :goto_10

    :cond_19
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto/16 :goto_11

    :cond_1a
    iget-object v7, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v7, Lws1;

    iget-object v8, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v8, Lws1;

    iget-object v10, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v10, Lvjh;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v11, v8

    move-object/from16 v8, p1

    goto :goto_e

    :cond_1b
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v10, v6, Ldu1;->d0:Lvjh;

    new-instance v7, Lot1;

    invoke-direct {v7, v6, v3}, Lot1;-><init>(Ldu1;I)V

    invoke-virtual {v6, v7}, Ldu1;->d0(Lna8;)Load;

    move-result-object v7

    iget-object v11, v7, Load;->E:Ljava/lang/Object;

    check-cast v11, Lws1;

    iget-object v7, v7, Load;->F:Ljava/lang/Object;

    check-cast v7, Lws1;

    iget-object v12, v6, Ldu1;->s:Lun1;

    iput-object v10, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v11, v5, Lsn;->H:Ljava/lang/Object;

    iput-object v7, v5, Lsn;->I:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    iget-object v8, v12, Lun1;->a:Lao1;

    invoke-virtual {v8, v5}, Lao1;->g(Lg85;)Ljava/lang/Object;

    move-result-object v8

    if-ne v8, v9, :cond_1c

    goto/16 :goto_11

    :cond_1c
    :goto_e
    check-cast v8, Ljava/lang/Boolean;

    invoke-virtual {v8}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v8

    if-nez v8, :cond_1e

    invoke-static {v11, v7}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1d

    new-instance v2, Lhr1;

    invoke-direct {v2, v1}, Lhr1;-><init>(I)V

    invoke-virtual {v6, v2}, Ldu1;->d0(Lna8;)Load;

    :cond_1d
    :goto_f
    move-object v9, v0

    goto :goto_11

    :cond_1e
    const/4 v1, 0x0

    if-eqz v10, :cond_1f

    invoke-interface {v10, v1}, Lyt9;->d(Ljava/util/concurrent/CancellationException;)V

    :cond_1f
    iget-object v7, v6, Ldu1;->d0:Lvjh;

    if-ne v7, v10, :cond_20

    iput-object v1, v6, Ldu1;->d0:Lvjh;

    :cond_20
    invoke-virtual {v6}, Ldu1;->d()V

    iget-object v7, v6, Ldu1;->s:Lun1;

    iput-object v1, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v1, v5, Lsn;->H:Ljava/lang/Object;

    iput-object v1, v5, Lsn;->I:Ljava/lang/Object;

    iput v4, v5, Lsn;->F:I

    invoke-virtual {v7, v5}, Lun1;->c(Lg85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v9, :cond_21

    goto :goto_11

    :cond_21
    :goto_10
    invoke-virtual {v6}, Ldu1;->C()Z

    move-result v1

    if-eqz v1, :cond_22

    goto :goto_f

    :cond_22
    invoke-virtual {v6}, Ldu1;->w()Lls1;

    move-result-object v1

    if-eqz v1, :cond_24

    iget-object v4, v6, Ldu1;->c0:Lvjh;

    const/4 v5, 0x0

    if-eqz v4, :cond_23

    invoke-virtual {v4, v5}, Liu9;->d(Ljava/util/concurrent/CancellationException;)V

    :cond_23
    iget-object v4, v6, Ldu1;->e:Lxb5;

    new-instance v7, Lyn1;

    invoke-direct {v7, v1, v6, v5, v3}, Lyn1;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    invoke-static {v4, v5, v5, v7, v2}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    move-result-object v1

    iput-object v1, v6, Ldu1;->c0:Lvjh;

    :cond_24
    iget-object v1, v6, Ldu1;->t:Lro1;

    iget-object v1, v1, Lro1;->f:Lq52;

    sget-object v2, Ljo1;->a:Ljo1;

    invoke-interface {v1, v2}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, v6, Ldu1;->u:Li91;

    iget-boolean v2, v1, Li91;->g:Z

    if-eqz v2, :cond_25

    goto :goto_f

    :cond_25
    iget-object v1, v1, Li91;->e:Landroid/media/AudioTrack;

    if-eqz v1, :cond_1d

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v1, v2}, Landroid/media/AudioTrack;->setVolume(F)I

    goto :goto_f

    :goto_11
    return-object v9

    :pswitch_10
    sget-object v0, Lx7j;->a:Lx7j;

    sget-object v1, Lyb5;->E:Lyb5;

    iget v2, v5, Lsn;->F:I

    if-eqz v2, :cond_29

    if-eq v2, v8, :cond_28

    if-ne v2, v4, :cond_27

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    :cond_26
    move-object v9, v0

    goto :goto_14

    :cond_27
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_14

    :cond_28
    iget-object v2, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    iget-object v3, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v3, Lil0;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v6, v2

    move-object/from16 v2, p1

    goto :goto_12

    :cond_29
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v2, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v2, Lbp1;

    iget-object v3, v2, Lbp1;->p:Lil0;

    iget-object v6, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v6, Ljava/lang/String;

    iget-object v2, v2, Lbp1;->m:Lg9;

    iput-object v3, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v6, v5, Lsn;->H:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v2, v6, v5}, Lg9;->h(Ljava/lang/String;Lfzh;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v1, :cond_2a

    goto :goto_13

    :cond_2a
    :goto_12
    check-cast v2, Lcom/anthropic/hermes/api/result/ApiResult;

    const/4 v7, 0x0

    iput-object v7, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v7, v5, Lsn;->H:Ljava/lang/Object;

    iput v4, v5, Lsn;->F:I

    invoke-static {v3, v6, v2}, Lpnl;->j(Lil0;Ljava/lang/String;Lcom/anthropic/hermes/api/result/ApiResult;)V

    if-ne v0, v1, :cond_26

    :goto_13
    move-object v9, v1

    :goto_14
    return-object v9

    :pswitch_11
    iget-object v0, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Lsob;

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lun1;

    sget-object v2, Lyb5;->E:Lyb5;

    iget v3, v5, Lsn;->F:I

    if-eqz v3, :cond_2c

    if-ne v3, v8, :cond_2b

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_15

    :cond_2b
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_16

    :cond_2c
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v10, v1, Lun1;->b:Lt4c;

    invoke-virtual {v0}, Lsob;->e()Ld81;

    iget v11, v0, Lsob;->L:I

    iget-object v3, v5, Lsn;->I:Ljava/lang/Object;

    move-object v12, v3

    check-cast v12, Ljava/lang/Integer;

    iget-object v3, v5, Lsn;->J:Ljava/lang/Object;

    move-object v14, v3

    check-cast v14, Lde;

    new-instance v15, Lqn1;

    invoke-direct {v15, v1, v6}, Lqn1;-><init>(Lun1;I)V

    iget v3, v1, Lun1;->h:I

    new-instance v4, Lqn1;

    invoke-direct {v4, v1, v8}, Lqn1;-><init>(Lun1;I)V

    sget-object v13, Lq4c;->H:Lq4c;

    new-instance v9, Ls4c;

    const/16 v18, 0x0

    move/from16 v16, v3

    move-object/from16 v17, v4

    invoke-direct/range {v9 .. v18}, Ls4c;-><init>(Lt4c;ILjava/lang/Integer;Lq4c;Lde;Lqn1;ILqn1;Le85;)V

    new-instance v3, Ltwf;

    invoke-direct {v3, v9}, Ltwf;-><init>(Lbb8;)V

    invoke-static {v3}, Lnck;->V(Lb18;)Lui2;

    move-result-object v3

    new-instance v4, Lho;

    const/4 v6, 0x5

    invoke-direct {v4, v1, v6, v0}, Lho;-><init>(Ljava/lang/Object;ILjava/lang/Object;)V

    iput v8, v5, Lsn;->F:I

    invoke-interface {v3, v4, v5}, Lb18;->a(Lc18;Le85;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v2, :cond_2d

    move-object v9, v2

    goto :goto_16

    :cond_2d
    :goto_15
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_16
    return-object v9

    :pswitch_12
    iget-object v0, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioManager;

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lq4e;

    sget-object v2, Lyb5;->E:Lyb5;

    iget v3, v5, Lsn;->F:I

    if-eqz v3, :cond_2f

    if-ne v3, v8, :cond_2e

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_17

    :cond_2e
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_18

    :cond_2f
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    new-instance v3, Ln71;

    invoke-direct {v3, v1, v6}, Ln71;-><init>(Lq4e;I)V

    iget-object v4, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v4, La81;

    iget-object v4, v4, La81;->a:Lmi6;

    invoke-interface {v4}, Lmi6;->b()Lqb5;

    move-result-object v4

    invoke-static {v4}, Lnk9;->g(Lqb5;)Ljava/util/concurrent/Executor;

    move-result-object v4

    invoke-static {v0, v4, v3}, Ls10;->q(Landroid/media/AudioManager;Ljava/util/concurrent/Executor;Ln71;)V

    iget-object v4, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v1, v4}, Lq4e;->t(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v4, Ln6;

    const/16 v6, 0x19

    invoke-direct {v4, v0, v6, v3}, Ln6;-><init>(Ljava/lang/Object;ILjava/lang/Object;)V

    const/4 v6, 0x0

    iput-object v6, v5, Lsn;->G:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-static {v1, v4, v5}, Ls05;->i(Lq4e;Lla8;Le85;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v2, :cond_30

    move-object v9, v2

    goto :goto_18

    :cond_30
    :goto_17
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_18
    return-object v9

    :pswitch_13
    iget-object v0, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v0, Ll11;

    sget-object v2, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_33

    if-eq v1, v8, :cond_32

    if-ne v1, v4, :cond_31

    iget-object v1, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v1, Lh0f;

    iget-object v3, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v3, Lwph;

    iget-object v7, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v7, Lh0f;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v9, v3

    move-object v3, v7

    move-object/from16 v7, p1

    goto :goto_20

    :cond_31
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_1f

    :cond_32
    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lh0f;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v3, p1

    goto :goto_1a

    :cond_33
    invoke-static/range {p1 .. p1}, Lzj6;->h(Ljava/lang/Object;)Lh0f;

    move-result-object v1

    :goto_19
    iget-object v3, v0, Ll11;->g:Ljava/lang/Object;

    check-cast v3, Lrlh;

    new-instance v7, Lk11;

    const/4 v9, 0x0

    invoke-direct {v7, v1, v9, v6}, Lk11;-><init>(Lh0f;Le85;I)V

    iput-object v1, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v9, v5, Lsn;->H:Ljava/lang/Object;

    iput-object v9, v5, Lsn;->I:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-static {v3, v7, v5}, Lnck;->j0(Lb18;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v2, :cond_34

    goto :goto_1e

    :cond_34
    :goto_1a
    check-cast v3, Lwph;

    if-eqz v3, :cond_35

    iget-object v7, v3, Lwph;->a:Ljava/lang/String;

    goto :goto_1b

    :cond_35
    const/4 v7, 0x0

    :goto_1b
    if-eqz v7, :cond_37

    iget-object v7, v3, Lwph;->a:Ljava/lang/String;

    invoke-virtual {v0}, Ll11;->k()Lwph;

    move-result-object v9

    if-eqz v9, :cond_36

    iget-object v9, v9, Lwph;->a:Ljava/lang/String;

    goto :goto_1c

    :cond_36
    const/4 v9, 0x0

    :goto_1c
    invoke-static {v7, v9}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_37

    move v7, v8

    goto :goto_1d

    :cond_37
    move v7, v6

    :goto_1d
    iput-object v1, v5, Lsn;->G:Ljava/lang/Object;

    iput-object v3, v5, Lsn;->H:Ljava/lang/Object;

    iput-object v1, v5, Lsn;->I:Ljava/lang/Object;

    iput v4, v5, Lsn;->F:I

    invoke-static {v0, v7, v5}, Ll11;->a(Ll11;ZLg85;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v2, :cond_38

    :goto_1e
    move-object v9, v2

    :goto_1f
    return-object v9

    :cond_38
    move-object v9, v3

    move-object v3, v1

    :goto_20
    check-cast v7, Lwph;

    if-nez v7, :cond_39

    goto :goto_21

    :cond_39
    move-object v9, v7

    :goto_21
    iput-object v9, v1, Lh0f;->E:Ljava/lang/Object;

    move-object v1, v3

    goto :goto_19

    :pswitch_14
    iget-object v0, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v0, Lhx0;

    iget-object v0, v0, Lhx0;->b:Lcu0;

    sget-object v2, Lx7j;->a:Lx7j;

    iget-object v3, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v3, Lgx0;

    sget-object v9, Lyb5;->E:Lyb5;

    iget v10, v5, Lsn;->F:I

    if-eqz v10, :cond_3b

    if-ne v10, v8, :cond_3a

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Ljava/util/List;

    check-cast v1, Ljava/util/List;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object v7, v1

    move-object/from16 v1, p1

    goto :goto_23

    :cond_3a
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto/16 :goto_29

    :cond_3b
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v7, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v7, Lla8;

    invoke-interface {v7}, Lla8;->a()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/List;

    iget-object v10, v3, Lgx0;->f:Lydd;

    const/4 v11, 0x0

    invoke-virtual {v10, v11}, Lydd;->setValue(Ljava/lang/Object;)V

    iget-object v10, v3, Lgx0;->c:Lip;

    invoke-virtual {v10}, Lip;->a()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Number;

    invoke-virtual {v10}, Ljava/lang/Number;->longValue()J

    move-result-wide v12

    iput-wide v12, v3, Lgx0;->i:J

    sget-object v10, Luw0;->E:Luw0;

    iget-object v12, v3, Lgx0;->d:Lydd;

    invoke-virtual {v12, v10}, Lydd;->setValue(Ljava/lang/Object;)V

    if-nez v7, :cond_3c

    sget-object v7, Lcom/anthropic/hermes/analytics/events/CodeEvents$ArtifactLoadFailureCause;->SIGN_IN_REQUIRED:Lcom/anthropic/hermes/analytics/events/CodeEvents$ArtifactLoadFailureCause;

    invoke-virtual {v3, v7, v11}, Lgx0;->a(Lcom/anthropic/hermes/analytics/events/CodeEvents$ArtifactLoadFailureCause;Ljava/lang/Integer;)V

    const/4 v7, 0x0

    :cond_3c
    if-nez v7, :cond_3d

    :goto_22
    move-object v9, v2

    goto/16 :goto_29

    :cond_3d
    new-instance v10, Le7;

    invoke-direct {v10, v1, v3}, Le7;-><init>(ILjava/lang/Object;)V

    invoke-static {v10}, Lp8;->U(Lla8;)Ltwf;

    move-result-object v1

    new-instance v10, Lf90;

    invoke-direct {v10, v1, v4}, Lf90;-><init>(Lb18;I)V

    move-object v1, v7

    check-cast v1, Ljava/util/List;

    iput-object v1, v5, Lsn;->G:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-static {v10, v5}, Lnck;->i0(Lb18;Le85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v9, :cond_3e

    goto/16 :goto_29

    :cond_3e
    :goto_23
    check-cast v1, Landroid/webkit/WebView;

    invoke-static {}, Landroid/webkit/WebView;->getCurrentWebViewPackage()Landroid/content/pm/PackageInfo;

    move-result-object v4

    if-eqz v4, :cond_3f

    iget-object v4, v4, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    goto :goto_24

    :cond_3f
    const/4 v4, 0x0

    :goto_24
    sget-object v5, Lcx0;->a:Ljava/util/Set;

    if-eqz v4, :cond_40

    const/16 v5, 0x2e

    invoke-static {v4, v5}, Lhrh;->e1(Ljava/lang/String;C)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lorh;->q0(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v9

    goto :goto_25

    :cond_40
    const/4 v9, 0x0

    :goto_25
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v4, v8}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V

    if-eqz v9, :cond_41

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const/16 v9, 0x6f

    if-lt v5, v9, :cond_41

    move v6, v8

    :cond_41
    invoke-virtual {v4, v1, v6}, Landroid/webkit/CookieManager;->setAcceptThirdPartyCookies(Landroid/webkit/WebView;Z)V

    iget-object v5, v0, Lcu0;->c:Ljava/lang/String;

    const-string v6, "https://"

    invoke-static {v6, v5}, Lc40;->j(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object v6, v7

    check-cast v6, Ljava/lang/Iterable;

    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_26
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_42

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-virtual {v4, v5, v9}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_26

    :cond_42
    invoke-virtual {v4, v5}, Landroid/webkit/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v7}, Lcx0;->g(Ljava/lang/String;Ljava/util/List;)Ljava/util/List;

    move-result-object v6

    check-cast v6, Ljava/lang/Iterable;

    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_27
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_43

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    const-string v10, "/"

    invoke-static {v9, v0, v10}, Lcx0;->b(Ljava/lang/String;Lcu0;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v4, v5, v9}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_27

    :cond_43
    const-string v6, "/api/frame/"

    invoke-virtual {v5, v6}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Landroid/webkit/CookieManager;->getCookie(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v7}, Lcx0;->g(Ljava/lang/String;Ljava/util/List;)Ljava/util/List;

    move-result-object v6

    check-cast v6, Ljava/lang/Iterable;

    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_28
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_44

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    const-string v9, "/api"

    invoke-static {v7, v0, v9}, Lcx0;->b(Ljava/lang/String;Lcu0;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v5, v7}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_28

    :cond_44
    iput-boolean v8, v3, Lgx0;->h:Z

    invoke-virtual {v0}, Lcu0;->a()Ljava/lang/String;

    move-result-object v0

    const-string v2, "LOAD_URL"

    invoke-static {v2, v0}, Lcom/anthropic/hermes/HermesLog;->wv(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto/16 :goto_22

    :goto_29
    return-object v9

    :pswitch_15
    iget-object v0, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v0, Lvgc;

    sget-object v1, Lyb5;->E:Lyb5;

    iget v2, v5, Lsn;->F:I

    if-eqz v2, :cond_46

    if-ne v2, v8, :cond_45

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v2, p1

    goto :goto_2b

    :cond_45
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    :goto_2a
    const/4 v9, 0x0

    goto :goto_2d

    :cond_46
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-interface {v0, v2}, Lvgc;->setValue(Ljava/lang/Object;)V

    iget-object v2, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v2, Ldt0;

    iget-object v3, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v3, Liyf;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v2, v3, v5}, Ldt0;->P(Liyf;Lg85;)Ljava/lang/Enum;

    move-result-object v2

    if-ne v2, v1, :cond_47

    move-object v9, v1

    goto :goto_2d

    :cond_47
    :goto_2b
    check-cast v2, Lus0;

    invoke-virtual {v2}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    if-eqz v1, :cond_49

    if-eq v1, v8, :cond_49

    if-ne v1, v4, :cond_48

    iget-object v0, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v0, Lla8;

    invoke-interface {v0}, Lla8;->a()Ljava/lang/Object;

    goto :goto_2c

    :cond_48
    invoke-static {}, Lla7;->d()V

    goto :goto_2a

    :cond_49
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v0, v1}, Lvgc;->setValue(Ljava/lang/Object;)V

    :goto_2c
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_2d
    return-object v9

    :pswitch_16
    sget-object v0, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_4b

    if-ne v1, v8, :cond_4a

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v1, p1

    goto :goto_2e

    :cond_4a
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_2f

    :cond_4b
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Landroid/app/Activity;

    iget-object v2, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v2, Lur0;

    iget-object v3, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v3, Lxr0;

    iget-object v3, v3, Lxr0;->f:Lmi6;

    iput v8, v5, Lsn;->F:I

    invoke-static {v1, v2, v3, v5}, Lpx0;->a(Landroid/app/Activity;Lur0;Lmi6;Lg85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_4c

    move-object v9, v0

    goto :goto_2f

    :cond_4c
    :goto_2e
    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_4d

    iget-object v0, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v0, Lla8;

    invoke-interface {v0}, Lla8;->a()Ljava/lang/Object;

    :cond_4d
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_2f
    return-object v9

    :pswitch_17
    sget-object v0, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_4f

    if-ne v1, v8, :cond_4e

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_30

    :cond_4e
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_31

    :cond_4f
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v1, Lq4e;

    new-instance v2, Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v13, 0x0

    invoke-direct {v2, v13}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    new-instance v3, Lno0;

    invoke-direct {v3, v2, v1}, Lno0;-><init>(Ljava/util/concurrent/atomic/AtomicReference;Lq4e;)V

    new-instance v9, Lo0;

    iget-object v1, v5, Lsn;->H:Ljava/lang/Object;

    move-object v10, v1

    check-cast v10, Ltml;

    iget-object v1, v5, Lsn;->I:Ljava/lang/Object;

    move-object v11, v1

    check-cast v11, Landroid/content/Context;

    iget-object v1, v5, Lsn;->J:Ljava/lang/Object;

    move-object v12, v1

    check-cast v12, Lco0;

    const/16 v14, 0xf

    invoke-direct/range {v9 .. v14}, Lo0;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput v8, v5, Lsn;->F:I

    invoke-static {v3, v9, v5}, Lxwf;->g0(Lob5;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_50

    move-object v9, v0

    goto :goto_31

    :cond_50
    :goto_30
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_31
    return-object v9

    :pswitch_18
    iget-object v0, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v0, Landroid/content/Context;

    iget-object v1, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v1, Llo0;

    sget-object v2, Lyb5;->E:Lyb5;

    iget v3, v5, Lsn;->F:I

    if-eqz v3, :cond_52

    if-ne v3, v8, :cond_51

    iget-object v2, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v2, Lp4e;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v6, p1

    goto :goto_33

    :cond_51
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    :goto_32
    const/4 v9, 0x0

    goto/16 :goto_3b

    :cond_52
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v3, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v3, Lp4e;

    iget-object v6, v1, Llo0;->i:Lydd;

    invoke-virtual {v6}, Lydd;->getValue()Ljava/lang/Object;

    move-result-object v6

    if-nez v6, :cond_54

    iget-object v6, v1, Llo0;->d:Ltml;

    iget-object v6, v6, Ltml;->G:Ljava/lang/Object;

    check-cast v6, Lwaa;

    if-eqz v6, :cond_54

    iget-object v7, v1, Llo0;->f:Ldj8;

    iget-object v9, v1, Llo0;->a:Ljava/lang/String;

    iput-object v3, v5, Lsn;->G:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v7, v0, v6, v9, v5}, Ldj8;->c(Landroid/content/Context;Lwaa;Ljava/lang/String;Lg85;)Ljava/lang/Object;

    move-result-object v6

    if-ne v6, v2, :cond_53

    move-object v9, v2

    goto/16 :goto_3b

    :cond_53
    move-object v2, v3

    :goto_33
    move-object v3, v2

    goto :goto_34

    :cond_54
    const/4 v6, 0x0

    :goto_34
    iget-object v2, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v2, Lvgc;

    invoke-static {}, Lgbh;->j()Lzah;

    move-result-object v5

    instance-of v7, v5, Lsgc;

    if-eqz v7, :cond_55

    check-cast v5, Lsgc;

    goto :goto_35

    :cond_55
    const/4 v5, 0x0

    :goto_35
    if-eqz v5, :cond_5b

    const/4 v7, 0x0

    invoke-virtual {v5, v7, v7}, Lsgc;->C(Lna8;Lna8;)Lsgc;

    move-result-object v5

    if-eqz v5, :cond_5b

    :try_start_0
    invoke-virtual {v5}, Lzah;->j()Lzah;

    move-result-object v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v9, v1, Llo0;->e:Lco0;

    iget-object v10, v1, Llo0;->j:Lydd;

    invoke-static {v9}, Lnpl;->i(Lco0;)Z

    move-result v11

    if-nez v11, :cond_59

    const-string v11, "appwidget"

    invoke-virtual {v0, v11}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    check-cast v11, Landroid/appwidget/AppWidgetManager;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v12, v9, Lco0;->a:I

    invoke-virtual {v11, v12}, Landroid/appwidget/AppWidgetManager;->getAppWidgetInfo(I)Landroid/appwidget/AppWidgetProviderInfo;

    move-result-object v12

    if-nez v12, :cond_56

    const-wide/16 v12, 0x0

    goto :goto_37

    :cond_56
    iget v13, v12, Landroid/appwidget/AppWidgetProviderInfo;->minWidth:I

    iget v14, v12, Landroid/appwidget/AppWidgetProviderInfo;->resizeMode:I

    and-int/2addr v8, v14

    const v14, 0x7fffffff

    if-eqz v8, :cond_57

    iget v8, v12, Landroid/appwidget/AppWidgetProviderInfo;->minResizeWidth:I

    goto :goto_36

    :cond_57
    move v8, v14

    :goto_36
    invoke-static {v13, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    iget v13, v12, Landroid/appwidget/AppWidgetProviderInfo;->minHeight:I

    iget v15, v12, Landroid/appwidget/AppWidgetProviderInfo;->resizeMode:I

    and-int/2addr v4, v15

    if-eqz v4, :cond_58

    iget v14, v12, Landroid/appwidget/AppWidgetProviderInfo;->minResizeHeight:I

    :cond_58
    invoke-static {v13, v14}, Ljava/lang/Math;->min(II)I

    move-result v4

    int-to-float v8, v8

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v8, v0

    int-to-float v4, v4

    div-float/2addr v4, v0

    invoke-static {v8, v4}, Lnck;->K(FF)J

    move-result-wide v12

    :goto_37
    new-instance v0, Ldl6;

    invoke-direct {v0, v12, v13}, Ldl6;-><init>(J)V

    invoke-interface {v2, v0}, Lvgc;->setValue(Ljava/lang/Object;)V

    invoke-virtual {v10}, Lydd;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Bundle;

    if-nez v0, :cond_59

    iget v0, v9, Lco0;->a:I

    invoke-virtual {v11, v0}, Landroid/appwidget/AppWidgetManager;->getAppWidgetOptions(I)Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v10, v0}, Lydd;->setValue(Ljava/lang/Object;)V

    goto :goto_38

    :catchall_0
    move-exception v0

    goto :goto_39

    :cond_59
    :goto_38
    if-eqz v6, :cond_5a

    iget-object v0, v1, Llo0;->i:Lydd;

    invoke-virtual {v0, v6}, Lydd;->setValue(Ljava/lang/Object;)V

    :cond_5a
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v3, v0}, Lp4e;->setValue(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    invoke-static {v7}, Lzah;->q(Lzah;)V

    invoke-virtual {v5}, Lsgc;->w()Lkvl;

    move-result-object v0

    invoke-virtual {v0}, Lkvl;->i()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    invoke-virtual {v5}, Lsgc;->c()V

    sget-object v9, Lx7j;->a:Lx7j;

    goto :goto_3b

    :catchall_1
    move-exception v0

    goto :goto_3a

    :goto_39
    :try_start_3
    invoke-static {v7}, Lzah;->q(Lzah;)V

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :goto_3a
    invoke-virtual {v5}, Lsgc;->c()V

    throw v0

    :cond_5b
    const-string v0, "Cannot create a mutable snapshot of an read-only snapshot"

    invoke-static {v0}, Lla7;->k(Ljava/lang/String;)V

    goto/16 :goto_32

    :goto_3b
    return-object v9

    :pswitch_19
    iget-object v0, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v0, Llq2;

    sget-object v1, Lyb5;->E:Lyb5;

    iget v4, v5, Lsn;->F:I

    if-eqz v4, :cond_5d

    if-ne v4, v8, :cond_5c

    iget-object v4, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v4, Lj52;

    iget-object v6, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v6, Lxb5;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v7, p1

    goto :goto_3d

    :cond_5c
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_3f

    :cond_5d
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v4, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v4, Lxb5;

    invoke-interface {v0}, Luue;->iterator()Lj52;

    move-result-object v6

    move-object/from16 v26, v6

    move-object v6, v4

    move-object/from16 v4, v26

    :goto_3c
    iput-object v6, v5, Lsn;->H:Ljava/lang/Object;

    iput-object v4, v5, Lsn;->G:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v4, v5}, Lj52;->b(Le85;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v1, :cond_5e

    move-object v9, v1

    goto :goto_3f

    :cond_5e
    :goto_3d
    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v7

    if-eqz v7, :cond_60

    invoke-virtual {v4}, Lj52;->c()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Llof;

    invoke-interface {v0}, Luue;->m()Ljava/lang/Object;

    move-result-object v9

    invoke-static {v9}, Lfr2;->b(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Llof;

    if-nez v9, :cond_5f

    goto :goto_3e

    :cond_5f
    move-object v7, v9

    :goto_3e
    new-instance v9, Lta0;

    iget-object v10, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v10, Lua0;

    const/4 v11, 0x0

    invoke-direct {v9, v10, v7, v11, v3}, Lta0;-><init>(Lua0;Llof;Le85;I)V

    invoke-static {v6, v11, v11, v9, v2}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    goto :goto_3c

    :cond_60
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_3f
    return-object v9

    :pswitch_1a
    iget-object v0, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v0, Llq2;

    sget-object v1, Lyb5;->E:Lyb5;

    iget v3, v5, Lsn;->F:I

    if-eqz v3, :cond_62

    if-ne v3, v8, :cond_61

    iget-object v3, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v3, Lj52;

    iget-object v4, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v4, Lxb5;

    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    move-object/from16 v7, p1

    goto :goto_41

    :cond_61
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto :goto_43

    :cond_62
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v3, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v3, Lxb5;

    invoke-interface {v0}, Luue;->iterator()Lj52;

    move-result-object v4

    move-object/from16 v26, v4

    move-object v4, v3

    move-object/from16 v3, v26

    :goto_40
    iput-object v4, v5, Lsn;->H:Ljava/lang/Object;

    iput-object v3, v5, Lsn;->G:Ljava/lang/Object;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v3, v5}, Lj52;->b(Le85;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v1, :cond_63

    move-object v9, v1

    goto :goto_43

    :cond_63
    :goto_41
    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v7

    if-eqz v7, :cond_65

    invoke-virtual {v3}, Lj52;->c()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Llof;

    invoke-interface {v0}, Luue;->m()Ljava/lang/Object;

    move-result-object v9

    invoke-static {v9}, Lfr2;->b(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Llof;

    if-nez v9, :cond_64

    goto :goto_42

    :cond_64
    move-object v7, v9

    :goto_42
    new-instance v9, Ldb0;

    iget-object v10, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v10, Lfb0;

    const/4 v11, 0x0

    invoke-direct {v9, v10, v7, v11, v6}, Ldb0;-><init>(Lfb0;Llof;Le85;I)V

    invoke-static {v4, v11, v11, v9, v2}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    goto :goto_40

    :cond_65
    sget-object v9, Lx7j;->a:Lx7j;

    :goto_43
    return-object v9

    :pswitch_1b
    sget-object v0, Lyb5;->E:Lyb5;

    iget v1, v5, Lsn;->F:I

    if-eqz v1, :cond_67

    if-eq v1, v8, :cond_66

    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    :goto_44
    const/4 v9, 0x0

    goto :goto_46

    :cond_66
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_45

    :cond_67
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object v1, v5, Lsn;->G:Ljava/lang/Object;

    move-object v10, v1

    check-cast v10, Lcsd;

    new-instance v9, Lgo;

    iget-object v1, v5, Lsn;->H:Ljava/lang/Object;

    move-object v11, v1

    check-cast v11, Lna8;

    iget-object v1, v5, Lsn;->I:Ljava/lang/Object;

    move-object v12, v1

    check-cast v12, Le40;

    iget-object v1, v5, Lsn;->J:Ljava/lang/Object;

    move-object v13, v1

    check-cast v13, Lsga;

    const/4 v14, 0x0

    const/4 v15, 0x1

    invoke-direct/range {v9 .. v15}, Lgo;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    iput v8, v5, Lsn;->F:I

    invoke-static {v9, v5}, Ld2i;->x(Lbb8;Le85;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_68

    move-object v9, v0

    goto :goto_46

    :cond_68
    :goto_45
    invoke-static {}, Lla7;->s()V

    goto :goto_44

    :goto_46
    return-object v9

    :pswitch_1c
    sget-object v1, Lmm;->K:Lmm;

    sget-object v2, Lbn;->a:Lbn;

    iget-object v0, v5, Lsn;->H:Ljava/lang/Object;

    check-cast v0, Landroid/net/Uri;

    iget-object v3, v5, Lsn;->I:Ljava/lang/Object;

    check-cast v3, Lfn;

    iget-object v9, v3, Lfn;->e:Lydd;

    iget-object v10, v5, Lsn;->G:Ljava/lang/Object;

    check-cast v10, Lio;

    sget-object v11, Lyb5;->E:Lyb5;

    iget v12, v5, Lsn;->F:I

    if-eqz v12, :cond_6b

    if-eq v12, v8, :cond_6a

    if-ne v12, v4, :cond_69

    :try_start_4
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/util/concurrent/CancellationException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    move-object/from16 v0, p1

    goto :goto_49

    :catch_0
    move-exception v0

    goto/16 :goto_4a

    :cond_69
    invoke-static {v7}, Lla7;->k(Ljava/lang/String;)V

    const/4 v9, 0x0

    goto/16 :goto_4f

    :cond_6a
    :try_start_5
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/util/concurrent/CancellationException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0

    move-object/from16 v7, p1

    goto :goto_47

    :cond_6b
    invoke-static/range {p1 .. p1}, Ld2i;->b0(Ljava/lang/Object;)V

    :try_start_6
    iget-object v7, v10, Lio;->g:Lqsa;

    iput v8, v5, Lsn;->F:I

    invoke-virtual {v7, v0, v5}, Lqsa;->a(Landroid/net/Uri;Lg85;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v11, :cond_6c

    goto :goto_48

    :cond_6c
    :goto_47
    check-cast v7, Lgu7;

    if-eqz v7, :cond_6d

    iget-object v8, v7, Lgu7;->b:Ljava/lang/String;

    iget-object v12, v3, Lfn;->c:Lydd;

    invoke-virtual {v12, v8}, Lydd;->setValue(Ljava/lang/Object;)V

    iget-object v7, v7, Lgu7;->d:Ljava/lang/String;

    const-string v8, "image/"

    invoke-static {v7, v8, v6}, Lorh;->p0(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v6

    iget-object v3, v3, Lfn;->d:Lydd;

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-virtual {v3, v6}, Lydd;->setValue(Ljava/lang/Object;)V

    :cond_6d
    iget-object v3, v10, Lio;->f:Lnr;

    iput v4, v5, Lsn;->F:I

    iget-object v4, v3, Lnr;->c:Lmi6;

    invoke-interface {v4}, Lmi6;->b()Lqb5;

    move-result-object v4

    new-instance v6, Lm0;

    const/16 v7, 0x9

    const/4 v8, 0x0

    invoke-direct {v6, v3, v0, v8, v7}, Lm0;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    invoke-static {v4, v6, v5}, Lxwf;->g0(Lob5;Lbb8;Le85;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v11, :cond_6e

    :goto_48
    move-object v9, v11

    goto/16 :goto_4f

    :cond_6e
    :goto_49
    check-cast v0, Lmr;

    instance-of v3, v0, Lkr;

    if-eqz v3, :cond_6f

    new-instance v3, Lan;

    check-cast v0, Lkr;

    iget-object v0, v0, Lkr;->a:Lcom/anthropic/hermes/sessions/types/SessionFileAttachment;

    invoke-direct {v3, v0}, Lan;-><init>(Lcom/anthropic/hermes/sessions/types/SessionFileAttachment;)V

    invoke-virtual {v9, v3}, Lydd;->setValue(Ljava/lang/Object;)V

    goto/16 :goto_4e

    :cond_6f
    instance-of v3, v0, Llr;

    if-eqz v3, :cond_70

    sget-object v0, Lcn;->a:Lcn;

    invoke-virtual {v9, v0}, Lydd;->setValue(Ljava/lang/Object;)V

    sget-object v0, Lmm;->J:Lmm;

    invoke-virtual {v10, v0}, Lio;->m(Lmm;)V

    iget-object v0, v10, Lio;->A:Lvdd;

    invoke-virtual {v0}, Lvdd;->h()I

    move-result v0

    add-int/lit8 v3, v0, 0x1

    invoke-virtual {v10, v3}, Lio;->n(I)V

    invoke-static {v0}, Lr2e;->x(I)Ljava/lang/Integer;

    goto/16 :goto_4e

    :cond_70
    instance-of v0, v0, Ljr;

    if-eqz v0, :cond_71

    invoke-virtual {v9, v2}, Lydd;->setValue(Ljava/lang/Object;)V

    invoke-virtual {v10, v1}, Lio;->m(Lmm;)V

    iget-object v0, v10, Lio;->A:Lvdd;

    invoke-virtual {v0}, Lvdd;->h()I

    move-result v0

    add-int/lit8 v3, v0, 0x1

    invoke-virtual {v10, v3}, Lio;->n(I)V

    invoke-static {v0}, Lr2e;->x(I)Ljava/lang/Integer;

    goto :goto_4e

    :cond_71
    new-instance v0, Lkotlin/NoWhenBranchMatchedException;

    invoke-direct {v0}, Ljava/lang/RuntimeException;-><init>()V

    throw v0
    :try_end_6
    .catch Ljava/util/concurrent/CancellationException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0

    :goto_4a
    sget-object v3, Lxua;->J:Lxua;

    sget-object v4, Leva;->a:Ldva;

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {}, Ldva;->b()Z

    move-result v4

    if-nez v4, :cond_72

    goto :goto_4d

    :cond_72
    sget-object v4, Ldva;->b:Ljava/util/concurrent/CopyOnWriteArrayList;

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v4}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4b
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_73

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    move-object v8, v7

    check-cast v8, Leva;

    check-cast v8, Lt40;

    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4b

    :cond_73
    invoke-virtual {v6}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_74

    sget-object v4, Leva;->a:Ldva;

    const-string v7, "Upload: getLocalFileInfo/upload threw "

    invoke-static {v4, v0, v7}, Ll17;->r(Ldva;Ljava/lang/Exception;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4c
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_74

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Leva;

    check-cast v6, Lt40;

    const-string v7, "AgentChat"

    invoke-virtual {v6, v3, v7, v0}, Lt40;->b(Lxua;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4c

    :cond_74
    :goto_4d
    invoke-virtual {v9, v2}, Lydd;->setValue(Ljava/lang/Object;)V

    invoke-virtual {v10, v1}, Lio;->m(Lmm;)V

    iget-object v0, v10, Lio;->A:Lvdd;

    invoke-virtual {v0}, Lvdd;->h()I

    move-result v0

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v10, v1}, Lio;->n(I)V

    invoke-static {v0}, Lr2e;->x(I)Ljava/lang/Integer;

    :goto_4e
    iget-object v0, v10, Lio;->S:Ljava/util/LinkedHashMap;

    iget-object v1, v5, Lsn;->J:Ljava/lang/Object;

    check-cast v1, Ljava/util/UUID;

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v9, Lx7j;->a:Lx7j;

    :goto_4f
    return-object v9

    :catch_1
    move-exception v0

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
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
