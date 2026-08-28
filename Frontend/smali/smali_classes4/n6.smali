.class public final synthetic Ln6;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lla8;


# instance fields
.field public final synthetic E:I

.field public final synthetic F:Ljava/lang/Object;

.field public final synthetic G:Ljava/lang/Object;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Object;ILjava/lang/Object;)V
    .locals 0

    iput p2, p0, Ln6;->E:I

    iput-object p1, p0, Ln6;->F:Ljava/lang/Object;

    iput-object p3, p0, Ln6;->G:Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a()Ljava/lang/Object;
    .locals 8

    iget v0, p0, Ln6;->E:I

    const/4 v1, 0x3

    const/4 v2, 0x6

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioManager;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ln71;

    invoke-static {v0, p0}, Ls10;->A(Landroid/media/AudioManager;Ln71;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_0
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, La81;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lo71;

    iget-object v0, v0, La81;->b:Landroid/media/AudioManager;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p0}, Landroid/media/AudioManager;->unregisterAudioDeviceCallback(Landroid/media/AudioDeviceCallback;)V

    :cond_0
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_1
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, La81;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lo71;

    iget-object v0, v0, La81;->b:Landroid/media/AudioManager;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p0}, Landroid/media/AudioManager;->unregisterAudioDeviceCallback(Landroid/media/AudioDeviceCallback;)V

    :cond_1
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_2
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioManager;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ln71;

    invoke-static {v0, p0}, Ls10;->p(Landroid/media/AudioManager;Ln71;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_3
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Landroid/content/Context;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lyh0;

    invoke-virtual {v0, p0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_4
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Landroid/media/AudioManager;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lg71;

    invoke-virtual {v0, p0}, Landroid/media/AudioManager;->unregisterAudioPlaybackCallback(Landroid/media/AudioManager$AudioPlaybackCallback;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_5
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, La61;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lla8;

    iget-boolean v0, v0, La61;->a:Z

    if-nez v0, :cond_2

    invoke-interface {p0}, Lla8;->a()Ljava/lang/Object;

    :cond_2
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_6
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lna8;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lay0;

    iget-object p0, p0, Lay0;->a:Ljava/lang/String;

    invoke-interface {v0, p0}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_7
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lcom/anthropic/hermes/sessions/types/AskUserQuestionQuestion;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lzz0;

    const-string v1, "__OTHER__"

    invoke-virtual {v0}, Lcom/anthropic/hermes/sessions/types/AskUserQuestionQuestion;->getMultiSelect()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p0, v1}, Lzz0;->h(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-virtual {p0, v1}, Lzz0;->g(Ljava/lang/String;)V

    :goto_0
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_8
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lvgc;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ludd;

    invoke-interface {v0, v4}, Lvgc;->setValue(Ljava/lang/Object;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ludd;->i(F)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_9
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Ldt0;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lcom/anthropic/hermes/artifact/details/ArtifactFullScreenParams;

    check-cast p0, Lcom/anthropic/hermes/artifact/details/ArtifactFullScreenParams$PublishedArtifactFullScreenParams;

    invoke-virtual {p0}, Lcom/anthropic/hermes/artifact/details/ArtifactFullScreenParams$PublishedArtifactFullScreenParams;->getUuid-2-azyQ4()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v2, v0, Lzof;->a:Lx75;

    new-instance v3, Lgo;

    invoke-direct {v3, v0, p0, v4}, Lgo;-><init>(Ldt0;Ljava/lang/String;Le85;)V

    invoke-static {v2, v4, v4, v3, v1}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_a
    const-string v0, "ARTIFACT_VIEWER"

    const-string v1, "Intercepted artifact error callback -> prevented crash/dismissal"

    invoke-static {v0, v1}, Lcom/anthropic/hermes/HermesLog;->w(Ljava/lang/String;Ljava/lang/String;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_b
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    move-object v1, v0

    check-cast v1, Landroid/app/Activity;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lxr0;

    if-eqz v1, :cond_5

    invoke-virtual {p0}, Lxr0;->O()Lur0;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, v0, Lur0;->b:Lcom/anthropic/hermes/artifact/model/ArtifactMetadata;

    if-nez v0, :cond_4

    goto :goto_1

    :cond_4
    invoke-virtual {v0}, Lcom/anthropic/hermes/artifact/model/ArtifactMetadata;->getUuid()Lcom/anthropic/hermes/artifact/model/ArtifactUuid;

    move-result-object v2

    invoke-virtual {v2}, Lcom/anthropic/hermes/artifact/model/ArtifactUuid;->getValue()Ljava/lang/String;

    move-result-object v2

    const-string v3, "artifact_"

    invoke-static {v3, v2}, Lc40;->j(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lg3h;->G:Lg3h;

    iget-object v4, p0, Lxr0;->n:Lf96;

    invoke-virtual {v4}, Lf96;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v0}, Lcom/anthropic/hermes/artifact/model/ArtifactMetadata;->getIcon()Lze0;

    move-result-object v5

    iget v5, v5, Lze0;->b:I

    invoke-static {v1, v5}, Landroid/graphics/drawable/Icon;->createWithResource(Landroid/content/Context;I)Landroid/graphics/drawable/Icon;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    new-instance v6, Landroid/os/Bundle;

    invoke-direct {v6}, Landroid/os/Bundle;-><init>()V

    const-string v7, "com.anthropic.hermes.intent.extra.CHAT_ID"

    iget-object p0, p0, Lxr0;->c:Ljava/lang/String;

    invoke-virtual {v6, v7, p0}, Landroid/os/BaseBundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string p0, "com.anthropic.hermes.intent.extra.ARTIFACT_IDENTIFIER"

    invoke-virtual {v0}, Lcom/anthropic/hermes/artifact/model/ArtifactMetadata;->getIdentifier-eX_QYXY()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, p0, v0}, Landroid/os/BaseBundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static/range {v1 .. v6}, Ld2i;->W(Landroid/content/Context;Ljava/lang/String;Lg3h;Ljava/lang/String;Landroid/graphics/drawable/Icon;Landroid/os/Bundle;)V

    :cond_5
    :goto_1
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_c
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lfb7;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lcom/anthropic/hermes/core/events/b;

    instance-of v1, v0, Leb7;

    if-eqz v1, :cond_7

    iget-object p0, p0, Lcom/anthropic/hermes/core/events/b;->g:Lgvc;

    invoke-virtual {p0}, Lgvc;->a()Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0, v0}, Lsp9;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_6

    goto :goto_2

    :cond_6
    move v3, v5

    :cond_7
    :goto_2
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    :pswitch_d
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lh0f;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lla8;

    invoke-interface {p0}, Lla8;->a()Ljava/lang/Object;

    move-result-object p0

    iput-object p0, v0, Lh0f;->E:Ljava/lang/Object;

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_e
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    move-object v1, v0

    check-cast v1, Ld70;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ljava/lang/String;

    :try_start_0
    iget-object v0, v1, Ld70;->i:Landroid/speech/SpeechRecognizer;

    if-nez v0, :cond_8

    iget-object v0, v1, Ld70;->a:Landroid/content/Context;

    invoke-static {v0}, Ls10;->f(Landroid/content/Context;)Landroid/speech/SpeechRecognizer;

    move-result-object v0

    iget-object v2, v1, Ld70;->q:Lc70;

    invoke-virtual {v0, v2}, Landroid/speech/SpeechRecognizer;->setRecognitionListener(Landroid/speech/RecognitionListener;)V

    iput-object v0, v1, Ld70;->i:Landroid/speech/SpeechRecognizer;

    goto :goto_3

    :catch_0
    move-exception v0

    move-object p0, v0

    move-object v2, p0

    goto :goto_4

    :cond_8
    :goto_3
    invoke-static {p0}, Ld70;->c(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/speech/SpeechRecognizer;->startListening(Landroid/content/Intent;)V

    iput-boolean v3, v1, Ld70;->m:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_5

    :goto_4
    sget-object p0, Lr4i;->a:Ljava/util/List;

    const-string v3, "AndroidSpeechRecognitionEngine: on-device recognizer create failed"

    sget-object v4, Lhwg;->F:Lhwg;

    const/4 v6, 0x0

    const/16 v7, 0x38

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lr4i;->f(Ljava/lang/Throwable;Ljava/lang/String;Lhwg;Ljava/util/Map;Ljava/util/List;I)V

    iget-object p0, v1, Ld70;->k:Lh41;

    iget-object v2, p0, Lh41;->F:Ljava/lang/Object;

    monitor-enter v2

    :try_start_1
    sget-object v0, Loxe;->E:Loxe;

    iput-object v0, p0, Lh41;->G:Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v2

    iget-object p0, v1, Ld70;->b:Le70;

    invoke-virtual {p0}, Le70;->a()Ljava/lang/Object;

    iget-object p0, v1, Ld70;->g:Lq52;

    new-instance v0, Lufh;

    sget-object v1, Ltfh;->G:Ltfh;

    invoke-direct {v0, v1}, Lufh;-><init>(Ltfh;)V

    invoke-interface {p0, v0}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_5
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :catchall_0
    move-exception v0

    move-object p0, v0

    monitor-exit v2

    throw p0

    :pswitch_f
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Ldv;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lvgc;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-interface {p0, v1}, Lvgc;->setValue(Ljava/lang/Object;)V

    iget-object p0, v0, Ldv;->o:Lydd;

    invoke-virtual {p0, v1}, Lydd;->setValue(Ljava/lang/Object;)V

    sget-object p0, Lrx6;->E:Lrx6;

    iget-object v0, v0, Ldv;->p:Lydd;

    invoke-virtual {v0, p0}, Lydd;->setValue(Ljava/lang/Object;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_10
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Ljpf;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ldv;

    new-array v1, v3, [Lcom/anthropic/hermes/chatlist/all/bottomsheet/AllChatsListBottomSheetDestination;

    sget-object v3, Lcom/anthropic/hermes/chatlist/all/bottomsheet/AllChatsListBottomSheetDestination$Closed;->INSTANCE:Lcom/anthropic/hermes/chatlist/all/bottomsheet/AllChatsListBottomSheetDestination$Closed;

    aput-object v3, v1, v5

    new-instance v3, Lxv;

    invoke-direct {v3, v5, v1}, Lxv;-><init>(I[Ljava/lang/Object;)V

    new-instance v1, Lxyg;

    invoke-direct {v1, v2}, Lxyg;-><init>(I)V

    iget-object v0, v0, Ljpf;->E:Ln36;

    invoke-virtual {v0, v3, v1}, Ln36;->f(Lna8;Lbb8;)V

    iget-object v0, p0, Ldv;->o:Lydd;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lydd;->setValue(Ljava/lang/Object;)V

    sget-object v0, Lrx6;->E:Lrx6;

    iget-object p0, p0, Ldv;->p:Lydd;

    invoke-virtual {p0, v0}, Lydd;->setValue(Ljava/lang/Object;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_11
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lofa;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ldb3;

    invoke-virtual {v0}, Lofa;->h()Lffa;

    move-result-object v0

    iget v1, v0, Lffa;->n:I

    iget-object v0, v0, Lffa;->k:Ljava/util/List;

    invoke-static {v0}, Lun4;->E0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgfa;

    if-eqz v0, :cond_9

    iget v0, v0, Lgfa;->a:I

    goto :goto_6

    :cond_9
    move v0, v5

    :goto_6
    add-int/2addr v0, v3

    add-int/lit8 v1, v1, -0x5

    if-le v0, v1, :cond_a

    iget-boolean p0, p0, Ldb3;->a:Z

    if-eqz p0, :cond_a

    goto :goto_7

    :cond_a
    move v3, v5

    :goto_7
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    :pswitch_12
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lnt;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lcni;

    iget-object v1, v0, Lnt;->f:Lco5;

    iget-object v0, v0, Lnt;->g:Ljava/lang/String;

    iget-object p0, p0, Lcni;->b:Llq2;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v3, v1, Lco5;->b:Lmu3;

    new-instance v6, Lcom/anthropic/hermes/analytics/events/MobileAppUseEvents$MobileAppUseConversion;

    invoke-direct {v6, v0}, Lcom/anthropic/hermes/analytics/events/MobileAppUseEvents$MobileAppUseConversion;-><init>(Ljava/lang/String;)V

    sget-object v0, Lcom/anthropic/hermes/analytics/events/MobileAppUseEvents$MobileAppUseConversion;->Companion:Ld6c;

    invoke-virtual {v0}, Ld6c;->serializer()Lkotlinx/serialization/KSerializer;

    move-result-object v0

    check-cast v0, Luig;

    invoke-interface {v3, v6, v0}, Lmu3;->f(Lcom/anthropic/hermes/analytics/events/AnalyticsEvent;Luig;)V

    new-instance v0, Landroid/content/Intent;

    const-string v3, "android.intent.action.SHOW_ALARMS"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/high16 v3, 0x10000000

    invoke-virtual {v0, v3}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    :try_start_2
    iget-object v1, v1, Lco5;->a:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_8

    :catch_1
    move-exception v0

    new-instance v1, Lcom/anthropic/hermes/core/telemetry/SilentException;

    const-string v3, "Failed to open alarms"

    invoke-direct {v1, v3, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 v0, 0x7

    invoke-static {v1, v4, v5, v4, v0}, Lcom/anthropic/hermes/core/telemetry/SilentException;->a(Lcom/anthropic/hermes/core/telemetry/SilentException;Lhwg;ZLjava/util/List;I)V

    if-eqz p0, :cond_b

    new-instance v0, Lm47;

    const v1, 0x7f120869

    invoke-direct {v0, v1, v4, v4, v2}, Lm47;-><init>(ILp47;Lhc3;I)V

    invoke-interface {p0, v0}, Lffg;->t(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_b
    :goto_8
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_13
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lna8;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lfn;

    iget-object p0, p0, Lfn;->a:Ljava/util/UUID;

    invoke-interface {v0, p0}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_14
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lna8;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lci6;

    invoke-interface {v0, p0}, Lna8;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_15
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lofa;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Ljava/util/List;

    invoke-virtual {v0}, Lofa;->h()Lffa;

    move-result-object v0

    iget v0, v0, Lffa;->n:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {p0}, Lun4;->E0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lnm;

    if-eqz p0, :cond_c

    iget-object v4, p0, Lnm;->a:Ljava/lang/String;

    :cond_c
    new-instance p0, Load;

    invoke-direct {p0, v0, v4}, Load;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object p0

    :pswitch_16
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lno;

    if-eqz v0, :cond_d

    iget-object p0, p0, Lno;->b:Ljn;

    check-cast p0, Lio;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object p0, p0, Lio;->v:Lxjg;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    iget-object v3, p0, Lxjg;->F:Ljava/lang/Object;

    check-cast v3, Lx75;

    new-instance v5, Lm0;

    invoke-direct {v5, p0, v0, v4, v2}, Lm0;-><init>(Ljava/lang/Object;Ljava/lang/Object;Le85;I)V

    invoke-static {v3, v4, v4, v5, v1}, Lxwf;->J(Lxb5;Lob5;Lac5;Lbb8;I)Lvjh;

    :cond_d
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_17
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lofa;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lno;

    invoke-virtual {v0}, Lofa;->h()Lffa;

    move-result-object v0

    iget-object v1, v0, Lffa;->k:Ljava/util/List;

    invoke-static {v1}, Lun4;->E0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lgfa;

    if-eqz v1, :cond_e

    iget v1, v1, Lgfa;->a:I

    goto :goto_9

    :cond_e
    move v1, v5

    :goto_9
    add-int/2addr v1, v3

    iget v0, v0, Lffa;->n:I

    add-int/lit8 v0, v0, -0x5

    if-le v1, v0, :cond_f

    iget-object p0, p0, Lno;->b:Ljn;

    check-cast p0, Lio;

    iget-object p0, p0, Lio;->x:Lydd;

    invoke-virtual {p0}, Lydd;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    if-eqz p0, :cond_f

    goto :goto_a

    :cond_f
    move v3, v5

    :goto_a
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    :pswitch_18
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Ljn;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lvgc;

    check-cast v0, Lio;

    iget-object v0, v0, Lio;->t:Lzm;

    invoke-virtual {v0}, Lzm;->e()V

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-interface {p0, v0}, Lvgc;->setValue(Ljava/lang/Object;)V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_19
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lu0d;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lvgc;

    iget-object v1, v0, Lu0d;->a:Lfzc;

    invoke-interface {p0}, Lnlh;->getValue()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Luj;

    instance-of v2, p0, Lsj;

    if-eqz v2, :cond_10

    check-cast p0, Lsj;

    goto :goto_b

    :cond_10
    move-object p0, v4

    :goto_b
    if-eqz p0, :cond_11

    iget-object v4, p0, Lsj;->b:Ljava/time/LocalDate;

    :cond_11
    iget-object p0, v1, Lfzc;->u:Lydd;

    invoke-virtual {p0, v4}, Lydd;->setValue(Ljava/lang/Object;)V

    iget-object p0, v0, Lu0d;->b:Lveb;

    invoke-virtual {p0}, Lveb;->a()Ljava/lang/Object;

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_1a
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lra3;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Lrod;

    iget-object v0, v0, Lra3;->d:Lmu3;

    new-instance v1, Lcom/anthropic/hermes/analytics/events/ChatEvents$RecentPhotosStripOverflowTapped;

    invoke-direct {v1, v5}, Lcom/anthropic/hermes/analytics/events/ChatEvents$RecentPhotosStripOverflowTapped;-><init>(I)V

    sget-object v2, Lcom/anthropic/hermes/analytics/events/ChatEvents$RecentPhotosStripOverflowTapped;->Companion:Lk03;

    invoke-virtual {v2}, Lk03;->serializer()Lkotlinx/serialization/KSerializer;

    move-result-object v2

    check-cast v2, Luig;

    invoke-interface {v0, v1, v2}, Lmu3;->f(Lcom/anthropic/hermes/analytics/events/AnalyticsEvent;Luig;)V

    invoke-virtual {p0}, Lrod;->a()V

    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_1b
    iget-object v0, p0, Ln6;->F:Ljava/lang/Object;

    check-cast v0, Lzpa;

    iget-object p0, p0, Ln6;->G:Ljava/lang/Object;

    check-cast p0, Landroid/view/accessibility/AccessibilityManager;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-virtual {p0, v0}, Landroid/view/accessibility/AccessibilityManager;->removeAccessibilityStateChangeListener(Landroid/view/accessibility/AccessibilityManager$AccessibilityStateChangeListener;)Z

    iget-object v1, v0, Lzpa;->H:Lypa;

    if-eqz v1, :cond_12

    invoke-virtual {p0, v1}, Landroid/view/accessibility/AccessibilityManager;->removeTouchExplorationStateChangeListener(Landroid/view/accessibility/AccessibilityManager$TouchExplorationStateChangeListener;)Z

    :cond_12
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    if-lt v1, v2, :cond_13

    iget-object v0, v0, Lzpa;->I:Lxpa;

    if-eqz v0, :cond_13

    invoke-static {v0}, Llc;->f(Ljava/lang/Object;)Landroid/view/accessibility/AccessibilityManager$AccessibilityServicesStateChangeListener;

    move-result-object v0

    invoke-static {p0, v0}, Ld6;->g(Landroid/view/accessibility/AccessibilityManager;Landroid/view/accessibility/AccessibilityManager$AccessibilityServicesStateChangeListener;)V

    :cond_13
    sget-object p0, Lx7j;->a:Lx7j;

    return-object p0

    :pswitch_data_0
    .packed-switch 0x0
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
