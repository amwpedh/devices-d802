.class public Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;
.super Ljava/lang/Object;
.source "WifiLgeHs20MobileManageTree.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "WifiFqdnPPSxHomeSp_OtherHomePartners"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public fqdn:Ljava/lang/String;

.field public nodeName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 1462
    new-instance v0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners$1;

    invoke-direct {v0}, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners$1;-><init>()V

    sput-object v0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 1433
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1434
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 0
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 1436
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1437
    invoke-virtual {p0, p1}, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->readFromParcel(Landroid/os/Parcel;)V

    .line 1438
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "node"    # Ljava/lang/String;
    .param p2, "f"    # Ljava/lang/String;

    .prologue
    .line 1427
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1428
    const-string v0, "WifiLgeHs20MobileManageTree"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/OtherHomePartners/<node=<"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ">"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1429
    iput-object p1, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->nodeName:Ljava/lang/String;

    .line 1430
    iput-object p2, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->fqdn:Ljava/lang/String;

    .line 1431
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 1441
    const/4 v0, 0x0

    return v0
.end method

.method public readFromParcel(Landroid/os/Parcel;)V
    .locals 3
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 1450
    if-nez p1, :cond_1

    .line 1451
    const-string v0, "WifiLgeHs20MobileManageTree"

    const-string v1, "[OtherHomePartners/] Error !!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1460
    :cond_0
    :goto_0
    return-void

    .line 1453
    :cond_1
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->nodeName:Ljava/lang/String;

    .line 1454
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->fqdn:Ljava/lang/String;

    .line 1455
    # getter for: Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree;->DBG:Z
    invoke-static {}, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree;->access$000()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1456
    const-string v0, "WifiLgeHs20MobileManageTree"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/OtherHomePartners/<"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->nodeName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ">"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1457
    const-string v0, "WifiLgeHs20MobileManageTree"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "                                      |<"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->nodeName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ">"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/FQDN["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->fqdn:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 1445
    iget-object v0, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->nodeName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1446
    iget-object v0, p0, Lcom/lge/wifi/impl/hs20/WifiLgeHs20MobileManageTree$WifiFqdnPPSxHomeSp_OtherHomePartners;->fqdn:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 1447
    return-void
.end method
