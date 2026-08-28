.class public final enum Ltn6;
.super Ljava/lang/Enum;
.source "SourceFile"


# static fields
.field public static final enum E:Ltn6;

.field public static final enum F:Ltn6;

.field public static final enum G:Ltn6;

.field public static final synthetic H:[Ltn6;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Ltn6;

    const-string v1, "START"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ltn6;->E:Ltn6;

    new-instance v1, Ltn6;

    const-string v2, "DRAG"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ltn6;->F:Ltn6;

    new-instance v2, Ltn6;

    const-string v3, "END"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    sput-object v2, Ltn6;->G:Ltn6;

    filled-new-array {v0, v1, v2}, [Ltn6;

    move-result-object v0

    sput-object v0, Ltn6;->H:[Ltn6;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ltn6;
    .locals 1

    const-class v0, Ltn6;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ltn6;

    return-object p0
.end method

.method public static values()[Ltn6;
    .locals 1

    sget-object v0, Ltn6;->H:[Ltn6;

    invoke-virtual {v0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ltn6;

    return-object v0
.end method
