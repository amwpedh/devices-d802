.class Lcom/android/server/statusbar/StatusBarManagerService$2;
.super Ljava/lang/Object;
.source "StatusBarManagerService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/android/server/statusbar/StatusBarManagerService;->disableLocked(IILandroid/os/IBinder;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/statusbar/StatusBarManagerService;

.field final synthetic val$net:I


# direct methods
.method constructor <init>(Lcom/android/server/statusbar/StatusBarManagerService;I)V
    .locals 0

    .prologue
    .line 211
    iput-object p1, p0, Lcom/android/server/statusbar/StatusBarManagerService$2;->this$0:Lcom/android/server/statusbar/StatusBarManagerService;

    iput p2, p0, Lcom/android/server/statusbar/StatusBarManagerService$2;->val$net:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 213
    iget-object v0, p0, Lcom/android/server/statusbar/StatusBarManagerService$2;->this$0:Lcom/android/server/statusbar/StatusBarManagerService;

    iget-object v0, v0, Lcom/android/server/statusbar/StatusBarManagerService;->mNotificationDelegate:Lcom/android/server/notification/NotificationDelegate;

    iget v1, p0, Lcom/android/server/statusbar/StatusBarManagerService$2;->val$net:I

    invoke-interface {v0, v1}, Lcom/android/server/notification/NotificationDelegate;->onSetDisabled(I)V

    .line 214
    return-void
.end method