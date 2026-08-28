.class public final Lq15;
.super Lfzh;
.source "SourceFile"

# interfaces
.implements Leb8;


# instance fields
.field public E:I

.field public synthetic F:Ljava/lang/String;

.field public synthetic G:Lnf6;

.field public synthetic H:Ljava/lang/String;

.field public final synthetic I:Lncb;


# direct methods
.method public constructor <init>(Lncb;Le85;)V
    .locals 0

    iput-object p1, p0, Lq15;->I:Lncb;

    const/4 p1, 0x4

    invoke-direct {p0, p1, p2}, Lfzh;-><init>(ILe85;)V

    return-void
.end method


# virtual methods
.method public final i(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Ljava/lang/String;

    check-cast p2, Lnf6;

    check-cast p3, Ljava/lang/String;

    check-cast p4, Le85;

    new-instance v0, Lq15;

    iget-object p0, p0, Lq15;->I:Lncb;

    invoke-direct {v0, p0, p4}, Lq15;-><init>(Lncb;Le85;)V

    iput-object p1, v0, Lq15;->F:Ljava/lang/String;

    iput-object p2, v0, Lq15;->G:Lnf6;

    iput-object p3, v0, Lq15;->H:Ljava/lang/String;

    sget-object p0, Lx7j;->a:Lx7j;

    invoke-virtual {v0, p0}, Lq15;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    iget-object v2, p0, Lq15;->F:Ljava/lang/String;

    iget-object v0, p0, Lq15;->G:Lnf6;

    iget-object v6, p0, Lq15;->H:Ljava/lang/String;

    iget v1, p0, Lq15;->E:I

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v1, :cond_1

    if-ne v1, v3, :cond_0

    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    return-object p1

    :cond_0
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    return-object v4

    :cond_1
    invoke-static {p1}, Ld2i;->b0(Ljava/lang/Object;)V

    iget-object p1, v0, Lnf6;->a:Luf6;

    iget-object p1, p1, Luf6;->E:Ljava/lang/String;

    move-object v1, v4

    new-instance v4, Ljava/lang/Integer;

    const/16 v5, 0x32

    invoke-direct {v4, v5}, Ljava/lang/Integer;-><init>(I)V

    iget-object v5, v0, Lnf6;->b:Ljava/lang/String;

    invoke-static {v5}, Lhrh;->G0(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_2

    move-object v5, v1

    :cond_2
    iget-object v0, v0, Lnf6;->c:Lmf6;

    if-eqz v0, :cond_3

    iget-object v0, v0, Lmf6;->E:Ljava/lang/String;

    move-object v7, v0

    goto :goto_0

    :cond_3
    move-object v7, v1

    :goto_0
    iput-object v1, p0, Lq15;->F:Ljava/lang/String;

    iput-object v1, p0, Lq15;->G:Lnf6;

    iput-object v1, p0, Lq15;->H:Ljava/lang/String;

    iput v3, p0, Lq15;->E:I

    const-string v1, "https://jishnupg-hermes.hf.space/hermes/v1/directory/servers"

    iget-object v0, p0, Lq15;->I:Lncb;

    const-string v8, "remote"

    move-object v9, p0

    move-object v3, p1

    invoke-interface/range {v0 .. v9}, Lncb;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Le85;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_4

    return-object p1

    :cond_4
    return-object p0
.end method
