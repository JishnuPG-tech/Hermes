.class public final Lcom/anthropic/hermes/wear/PhoneWearableListenerService;
.super Lp3k;
.source "SourceFile"

# interfaces
.implements Lv5a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/anthropic/hermes/wear/PhoneWearableListenerService$AuthSyncCredentials;,
        Lcom/anthropic/hermes/wear/PhoneWearableListenerService$AuthSyncError;,
        Lcom/anthropic/hermes/wear/PhoneWearableListenerService$SerializableCookieSlim;
    }
.end annotation


# static fields
.field public static final synthetic R:I


# instance fields
.field public final M:Lbba;

.field public final N:Lbba;

.field public final O:Lbba;

.field public final P:Lc0i;

.field public final Q:Lvv9;


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lp3k;-><init>()V

    new-instance v0, Lsw;

    const/16 v1, 0xa

    invoke-direct {v0, p0, v1}, Lsw;-><init>(Lv5a;I)V

    sget-object v1, Llga;->E:Llga;

    invoke-static {v1, v0}, Lf3h;->D(Llga;Lla8;)Lbba;

    move-result-object v0

    iput-object v0, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->M:Lbba;

    new-instance v0, Lsw;

    const/16 v2, 0xb

    invoke-direct {v0, p0, v2}, Lsw;-><init>(Lv5a;I)V

    invoke-static {v1, v0}, Lf3h;->D(Llga;Lla8;)Lbba;

    move-result-object v0

    iput-object v0, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->N:Lbba;

    new-instance v0, Lsw;

    const/16 v2, 0xc

    invoke-direct {v0, p0, v2}, Lsw;-><init>(Lv5a;I)V

    invoke-static {v1, v0}, Lf3h;->D(Llga;Lla8;)Lbba;

    move-result-object v0

    iput-object v0, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->O:Lbba;

    new-instance v0, Lbha;

    const/16 v1, 0x15

    invoke-direct {v0, v1, p0}, Lbha;-><init>(ILjava/lang/Object;)V

    new-instance v1, Lc0i;

    invoke-direct {v1, v0}, Lc0i;-><init>(Lla8;)V

    iput-object v1, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->P:Lc0i;

    new-instance v0, Lr0d;

    const/16 v1, 0x19

    invoke-direct {v0, v1}, Lr0d;-><init>(I)V

    invoke-static {v0}, Lx5i;->d(Lna8;)Lvv9;

    move-result-object v0

    iput-object v0, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->Q:Lvv9;

    return-void
.end method

.method public static final f(Lcom/anthropic/hermes/wear/PhoneWearableListenerService;)Lcom/anthropic/hermes/wear/PhoneWearableListenerService$AuthSyncCredentials;
    .locals 14

    iget-object v1, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->N:Lbba;

    iget-object v2, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->O:Lbba;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sget-object v3, Lil0;->K:Lzy8;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {v0}, Lzy8;->J(Landroid/content/Context;)Lil0;

    move-result-object v3

    invoke-virtual {v3}, Lil0;->d()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    goto/16 :goto_5

    :cond_0
    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    const-string v6, "account_prefs"

    invoke-virtual {v6, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v5, v6, v7}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-interface {v5}, Landroid/content/SharedPreferences;->getAll()Ljava/util/Map;

    move-result-object v6

    if-nez v6, :cond_1

    sget-object v6, Lkx6;->E:Lkx6;

    :cond_1
    invoke-interface {v6}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v6

    check-cast v6, Ljava/lang/Iterable;

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_2
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_4

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    move-object v10, v9

    check-cast v10, Ljava/lang/String;

    const-string v11, "conway_saved_client_id"

    invoke-static {v10, v11}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_3

    invoke-virtual {v10}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const-string v11, "conway_composer_draft_"

    invoke-static {v10, v11, v7}, Lorh;->p0(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v11

    if-nez v11, :cond_3

    const-string v11, "conway_viewing_fork_"

    invoke-static {v10, v11, v7}, Lorh;->p0(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v11

    if-nez v11, :cond_3

    const-string v11, "conway_send_outbox_"

    invoke-static {v10, v11, v7}, Lorh;->p0(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v10

    if-eqz v10, :cond_2

    :cond_3
    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    invoke-virtual {v8}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_6

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-virtual {v8}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_5

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-interface {v6, v9}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_1

    :cond_5
    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_6
    const-string v6, "selected_org_id"

    invoke-interface {v5, v6, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_7

    invoke-static {v6}, Lcom/anthropic/hermes/types/strings/OrganizationId;->constructor-impl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_2

    :cond_7
    move-object v6, v4

    :goto_2
    if-eqz v6, :cond_8

    invoke-static {v6}, Lcom/anthropic/hermes/types/strings/OrganizationId;->box-impl(Ljava/lang/String;)Lcom/anthropic/hermes/types/strings/OrganizationId;

    move-result-object v6

    goto :goto_3

    :cond_8
    move-object v6, v4

    :goto_3
    invoke-static {v6}, Lp8;->F(Ljava/lang/Object;)Lydd;

    move-result-object v6

    const-string v8, "display_email"

    invoke-interface {v5, v8, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lp8;->F(Ljava/lang/Object;)Lydd;

    invoke-virtual {v6}, Lydd;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/anthropic/hermes/types/strings/OrganizationId;

    if-eqz v5, :cond_9

    invoke-virtual {v5}, Lcom/anthropic/hermes/types/strings/OrganizationId;->unbox-impl()Ljava/lang/String;

    move-result-object v5

    move-object v10, v5

    goto :goto_4

    :cond_9
    move-object v10, v4

    :goto_4
    if-nez v10, :cond_a

    :goto_5
    return-object v4

    :cond_a
    invoke-interface {v2}, Lbba;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lzf0;

    sget-object v6, Lxf0;->g:Lxf0;

    invoke-static {v5, v6}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b

    const-string v5, "user_cookies_"

    invoke-virtual {v5, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_6

    :cond_b
    invoke-virtual {v5}, Lzf0;->a()Ljava/lang/String;

    move-result-object v5

    const-string v6, "/"

    const-string v8, "-"

    invoke-static {v5, v6, v8}, Lorh;->n0(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "user_cookies___"

    const-string v8, "__"

    invoke-static {v6, v5, v8, v3}, Lc40;->l(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_6
    invoke-virtual {v0, v3, v7}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->getAll()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_c
    :goto_7
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_f

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const-string v6, "|sessionKey"

    invoke-static {v5, v6, v7}, Lorh;->h0(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v6

    if-eqz v6, :cond_c

    instance-of v6, v0, Ljava/lang/String;

    if-eqz v6, :cond_c

    :try_start_0
    iget-object v6, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->Q:Lvv9;

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    sget-object v8, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$SerializableCookieSlim;->Companion:Lcom/anthropic/hermes/wear/f;

    invoke-virtual {v8}, Lcom/anthropic/hermes/wear/f;->serializer()Lkotlinx/serialization/KSerializer;

    move-result-object v8

    check-cast v8, Lba6;

    invoke-virtual {v6, v0, v8}, Lou9;->b(Ljava/lang/String;Lba6;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$SerializableCookieSlim;

    invoke-virtual {v0}, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$SerializableCookieSlim;->getName()Ljava/lang/String;

    move-result-object v6

    const-string v8, "sessionKey"

    invoke-static {v6, v8}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    invoke-virtual {v0}, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$SerializableCookieSlim;->getValue()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    if-lez v6, :cond_c

    invoke-virtual {v0}, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$SerializableCookieSlim;->getValue()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v9, p0

    goto :goto_a

    :catch_0
    move-exception v0

    sget-object v6, Leva;->a:Ldva;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {}, Ldva;->b()Z

    move-result v6

    if-nez v6, :cond_d

    goto :goto_7

    :cond_d
    invoke-static {p0}, Ls3j;->K(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    sget-object v8, Ldva;->b:Ljava/util/concurrent/CopyOnWriteArrayList;

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v8}, Ljava/util/concurrent/CopyOnWriteArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_8
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_e

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    move-object v12, v11

    check-cast v12, Leva;

    check-cast v12, Lt40;

    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v9, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_8

    :cond_e
    invoke-virtual {v9}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_c

    sget-object v8, Leva;->a:Ldva;

    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {v0}, Leeg;->i(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    const-string v8, "Failed to deserialize cookie for key="

    const-string v11, ": "

    invoke-static {v8, v5, v11, v0}, Lc40;->l(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v9}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_9
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_c

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Leva;

    check-cast v8, Lt40;

    sget-object v9, Lxua;->I:Lxua;

    invoke-virtual {v8, v9, v6, v0}, Lt40;->b(Lxua;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_9

    :cond_f
    move-object v9, v4

    :goto_a
    if-nez v9, :cond_10

    goto/16 :goto_10

    :cond_10
    invoke-interface {v2}, Lbba;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lzf0;

    invoke-virtual {p0}, Lzf0;->a()Ljava/lang/String;

    move-result-object p0

    const-string v0, "localhost"

    invoke-static {p0, v0, v7}, Lhrh;->s0(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    if-nez v0, :cond_12

    const-string v0, "10.0.2.2"

    invoke-static {p0, v0, v7}, Lhrh;->s0(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    if-nez v0, :cond_12

    const-string v0, "127.0.0.1"

    invoke-static {p0, v0, v7}, Lhrh;->s0(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_c

    :cond_11
    :goto_b
    move-object v11, p0

    goto :goto_d

    :cond_12
    :goto_c
    const-string p0, "https://jishnupg-hermes.hf.space/hermes/v1/"

    goto :goto_b

    :goto_d
    invoke-interface {v1}, Lbba;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lbt1;

    invoke-virtual {p0}, Lbt1;->b()Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_13

    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p0, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    :cond_13
    move-object v12, v4

    invoke-interface {v1}, Lbba;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lbt1;

    invoke-virtual {p0}, Lbt1;->a()Ljava/lang/String;

    move-result-object p0

    const-string v0, "SLOW"

    invoke-static {p0, v0}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_14

    const p0, 0x3f4ccccd    # 0.8f

    :goto_e
    move v13, p0

    goto :goto_f

    :cond_14
    const-string v0, "FAST"

    invoke-static {p0, v0}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_15

    const p0, 0x3f99999a    # 1.2f

    goto :goto_e

    :cond_15
    const/high16 p0, 0x3f800000    # 1.0f

    goto :goto_e

    :goto_f
    new-instance v8, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$AuthSyncCredentials;

    invoke-direct/range {v8 .. v13}, Lcom/anthropic/hermes/wear/PhoneWearableListenerService$AuthSyncCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    move-object v4, v8

    :goto_10
    return-object v4
.end method

.method public static final g(Lcom/anthropic/hermes/wear/PhoneWearableListenerService;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lg85;)Ljava/lang/Object;
    .locals 9

    instance-of v0, p4, Llod;

    if-eqz v0, :cond_0

    move-object v0, p4

    check-cast v0, Llod;

    iget v1, v0, Llod;->G:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_0

    sub-int/2addr v1, v2

    iput v1, v0, Llod;->G:I

    goto :goto_0

    :cond_0
    new-instance v0, Llod;

    invoke-direct {v0, p0, p4}, Llod;-><init>(Lcom/anthropic/hermes/wear/PhoneWearableListenerService;Lg85;)V

    :goto_0
    iget-object p4, v0, Llod;->E:Ljava/lang/Object;

    iget v1, v0, Llod;->G:I

    const/4 v2, 0x1

    if-eqz v1, :cond_2

    if-ne v1, v2, :cond_1

    invoke-static {p4}, Ld2i;->b0(Ljava/lang/Object;)V

    goto :goto_1

    :cond_1
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-static {p0}, Lla7;->k(Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_2
    invoke-static {p4}, Ld2i;->b0(Ljava/lang/Object;)V

    new-instance v4, Lin9;

    sget-object p4, Ljk8;->c:Ljk8;

    sget-object v1, Lmtk;->d:Lqvk;

    sget-object v3, Lo3k;->E:Lo3k;

    invoke-direct {v4, p0, v1, v3, p4}, Lkk8;-><init>(Landroid/content/Context;Lqvk;Lhf0;Ljk8;)V

    sget-object p0, Lhs2;->a:Ljava/nio/charset/Charset;

    invoke-virtual {p3, p0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-static {}, Ltf9;->a()Lf4i;

    move-result-object p0

    new-instance v3, Ln91;

    const/16 v8, 0x1d

    move-object v5, p1

    move-object v6, p2

    invoke-direct/range {v3 .. v8}, Ln91;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    iput-object v3, p0, Lf4i;->a:Lw5f;

    const/16 p1, 0x5dd4

    iput p1, p0, Lf4i;->e:I

    sget-object p1, Ljuk;->b:Lrq7;

    filled-new-array {p1}, [Lrq7;

    move-result-object p1

    iput-object p1, p0, Lf4i;->d:[Lrq7;

    invoke-virtual {p0}, Lf4i;->a()Ltf9;

    move-result-object p0

    const/4 p1, 0x0

    invoke-virtual {v4, p1, p0}, Lkk8;->c(ILtf9;)Lx3m;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iput v2, v0, Llod;->G:I

    invoke-static {p0, v0}, Ldq2;->o(Lx3m;Lg85;)Ljava/lang/Object;

    move-result-object p0

    sget-object p1, Lyb5;->E:Lyb5;

    if-ne p0, p1, :cond_3

    return-object p1

    :cond_3
    :goto_1
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0
.end method


# virtual methods
.method public final bridge e()Ls5a;
    .locals 0

    invoke-static {}, Lw10;->C()Ls5a;

    move-result-object p0

    return-object p0
.end method

.method public final onDestroy()V
    .locals 1

    invoke-super {p0}, Lp3k;->onDestroy()V

    iget-object p0, p0, Lcom/anthropic/hermes/wear/PhoneWearableListenerService;->P:Lc0i;

    invoke-virtual {p0}, Lc0i;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lxb5;

    const/4 v0, 0x0

    invoke-static {p0, v0}, Ld2i;->w(Lxb5;Ljava/util/concurrent/CancellationException;)V

    return-void
.end method
