.class public Lcom/android/server/net/NetworkStatsCollection;
.super Ljava/lang/Object;
.source "NetworkStatsCollection.java"

# interfaces
.implements Lcom/android/internal/util/FileRotator$Reader;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/net/NetworkStatsCollection$Key;
    }
.end annotation


# static fields
.field private static final FILE_MAGIC:I = 0x414e4554

.field private static final VERSION_NETWORK_INIT:I = 0x1

.field private static final VERSION_UID_INIT:I = 0x1

.field private static final VERSION_UID_WITH_IDENT:I = 0x2

.field private static final VERSION_UID_WITH_SET:I = 0x4

.field private static final VERSION_UID_WITH_TAG:I = 0x3

.field private static final VERSION_UNIFIED_INIT:I = 0x10


# instance fields
.field private final mBucketDuration:J

.field protected mDirty:Z

.field private mEndMillis:J

.field private mStartMillis:J

.field protected mStats:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Lcom/android/server/net/NetworkStatsCollection$Key;",
            "Landroid/net/NetworkStatsHistory;",
            ">;"
        }
    .end annotation
.end field

.field private mTotalBytes:J


# direct methods
.method public constructor <init>(J)V
    .locals 1
    .param p1, "bucketDuration"    # J

    .prologue
    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 74
    invoke-static {}, Lcom/google/android/collect/Maps;->newHashMap()Ljava/util/HashMap;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    .line 87
    iput-wide p1, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    .line 88
    invoke-virtual {p0}, Lcom/android/server/net/NetworkStatsCollection;->reset()V

    .line 89
    return-void
.end method

.method private estimateBuckets()I
    .locals 4

    .prologue
    .line 499
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mEndMillis:J

    iget-wide v2, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    sub-long/2addr v0, v2

    const-wide v2, 0xb43e9400L

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    iget-wide v2, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    div-long/2addr v0, v2

    long-to-int v0, v0

    return v0
.end method

.method private findOrCreateHistory(Lcom/android/server/net/NetworkIdentitySet;III)Landroid/net/NetworkStatsHistory;
    .locals 8
    .param p1, "ident"    # Lcom/android/server/net/NetworkIdentitySet;
    .param p2, "uid"    # I
    .param p3, "set"    # I
    .param p4, "tag"    # I

    .prologue
    .line 239
    new-instance v1, Lcom/android/server/net/NetworkStatsCollection$Key;

    invoke-direct {v1, p1, p2, p3, p4}, Lcom/android/server/net/NetworkStatsCollection$Key;-><init>(Lcom/android/server/net/NetworkIdentitySet;III)V

    .line 240
    .local v1, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v3, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v3, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/NetworkStatsHistory;

    .line 243
    .local v0, "existing":Landroid/net/NetworkStatsHistory;
    const/4 v2, 0x0

    .line 244
    .local v2, "updated":Landroid/net/NetworkStatsHistory;
    if-nez v0, :cond_1

    .line 245
    new-instance v2, Landroid/net/NetworkStatsHistory;

    .end local v2    # "updated":Landroid/net/NetworkStatsHistory;
    iget-wide v4, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    const/16 v3, 0xa

    invoke-direct {v2, v4, v5, v3}, Landroid/net/NetworkStatsHistory;-><init>(JI)V

    .line 250
    .restart local v2    # "updated":Landroid/net/NetworkStatsHistory;
    :cond_0
    :goto_0
    if-eqz v2, :cond_2

    .line 251
    iget-object v3, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v3, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 254
    .end local v2    # "updated":Landroid/net/NetworkStatsHistory;
    :goto_1
    return-object v2

    .line 246
    .restart local v2    # "updated":Landroid/net/NetworkStatsHistory;
    :cond_1
    invoke-virtual {v0}, Landroid/net/NetworkStatsHistory;->getBucketDuration()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    cmp-long v3, v4, v6

    if-eqz v3, :cond_0

    .line 247
    new-instance v2, Landroid/net/NetworkStatsHistory;

    .end local v2    # "updated":Landroid/net/NetworkStatsHistory;
    iget-wide v4, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    invoke-direct {v2, v0, v4, v5}, Landroid/net/NetworkStatsHistory;-><init>(Landroid/net/NetworkStatsHistory;J)V

    .restart local v2    # "updated":Landroid/net/NetworkStatsHistory;
    goto :goto_0

    :cond_2
    move-object v2, v0

    .line 254
    goto :goto_1
.end method

.method private noteRecordedHistory(JJJ)V
    .locals 3
    .param p1, "startMillis"    # J
    .param p3, "endMillis"    # J
    .param p5, "totalBytes"    # J

    .prologue
    .line 492
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    cmp-long v0, p1, v0

    if-gez v0, :cond_0

    iput-wide p1, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    .line 493
    :cond_0
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mEndMillis:J

    cmp-long v0, p3, v0

    if-lez v0, :cond_1

    iput-wide p3, p0, Lcom/android/server/net/NetworkStatsCollection;->mEndMillis:J

    .line 494
    :cond_1
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mTotalBytes:J

    add-long/2addr v0, p5

    iput-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mTotalBytes:J

    .line 495
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mDirty:Z

    .line 496
    return-void
.end method

.method private recordHistory(Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;)V
    .locals 8
    .param p1, "key"    # Lcom/android/server/net/NetworkStatsCollection$Key;
    .param p2, "history"    # Landroid/net/NetworkStatsHistory;

    .prologue
    .line 216
    invoke-virtual {p2}, Landroid/net/NetworkStatsHistory;->size()I

    move-result v1

    if-nez v1, :cond_0

    .line 225
    :goto_0
    return-void

    .line 217
    :cond_0
    invoke-virtual {p2}, Landroid/net/NetworkStatsHistory;->getStart()J

    move-result-wide v2

    invoke-virtual {p2}, Landroid/net/NetworkStatsHistory;->getEnd()J

    move-result-wide v4

    invoke-virtual {p2}, Landroid/net/NetworkStatsHistory;->getTotalBytes()J

    move-result-wide v6

    move-object v1, p0

    invoke-direct/range {v1 .. v7}, Lcom/android/server/net/NetworkStatsCollection;->noteRecordedHistory(JJJ)V

    .line 219
    iget-object v1, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/NetworkStatsHistory;

    .line 220
    .local v0, "target":Landroid/net/NetworkStatsHistory;
    if-nez v0, :cond_1

    .line 221
    new-instance v0, Landroid/net/NetworkStatsHistory;

    .end local v0    # "target":Landroid/net/NetworkStatsHistory;
    invoke-virtual {p2}, Landroid/net/NetworkStatsHistory;->getBucketDuration()J

    move-result-wide v2

    invoke-direct {v0, v2, v3}, Landroid/net/NetworkStatsHistory;-><init>(J)V

    .line 222
    .restart local v0    # "target":Landroid/net/NetworkStatsHistory;
    iget-object v1, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 224
    :cond_1
    invoke-virtual {v0, p2}, Landroid/net/NetworkStatsHistory;->recordEntireHistory(Landroid/net/NetworkStatsHistory;)V

    goto :goto_0
.end method

.method protected static templateMatches(Landroid/net/NetworkTemplate;Lcom/android/server/net/NetworkIdentitySet;)Z
    .locals 3
    .param p0, "template"    # Landroid/net/NetworkTemplate;
    .param p1, "identSet"    # Lcom/android/server/net/NetworkIdentitySet;

    .prologue
    .line 529
    invoke-virtual {p1}, Lcom/android/server/net/NetworkIdentitySet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/NetworkIdentity;

    .line 530
    .local v1, "ident":Landroid/net/NetworkIdentity;
    invoke-virtual {p0, v1}, Landroid/net/NetworkTemplate;->matches(Landroid/net/NetworkIdentity;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 531
    const/4 v2, 0x1

    .line 534
    .end local v1    # "ident":Landroid/net/NetworkIdentity;
    :goto_0
    return v2

    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method


# virtual methods
.method public clearDirty()V
    .locals 1

    .prologue
    .line 128
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mDirty:Z

    .line 129
    return-void
.end method

.method public clearUsageByTemplate(Landroid/net/NetworkTemplate;)Z
    .locals 8
    .param p1, "template"    # Landroid/net/NetworkTemplate;

    .prologue
    const/4 v7, 0x1

    .line 450
    const/4 v6, 0x0

    new-array v5, v6, [Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 451
    .local v5, "removeKeys":[Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v6, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v6}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 452
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 453
    .local v3, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v6, v3, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-static {p1, v6}, Lcom/android/server/net/NetworkStatsCollection;->templateMatches(Landroid/net/NetworkTemplate;Lcom/android/server/net/NetworkIdentitySet;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 454
    const-class v6, Lcom/android/server/net/NetworkStatsCollection$Key;

    invoke-static {v6, v5, v3}, Lcom/android/internal/util/ArrayUtils;->appendElement(Ljava/lang/Class;[Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v5

    .end local v5    # "removeKeys":[Lcom/android/server/net/NetworkStatsCollection$Key;
    check-cast v5, [Lcom/android/server/net/NetworkStatsCollection$Key;

    .restart local v5    # "removeKeys":[Lcom/android/server/net/NetworkStatsCollection$Key;
    goto :goto_0

    .line 457
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    .end local v3    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_1
    move-object v0, v5

    .local v0, "arr$":[Lcom/android/server/net/NetworkStatsCollection$Key;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v4, :cond_2

    aget-object v3, v0, v2

    .line 458
    .restart local v3    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v6, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v6, v3}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 459
    iput-boolean v7, p0, Lcom/android/server/net/NetworkStatsCollection;->mDirty:Z

    .line 457
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 462
    .end local v3    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_2
    return v7
.end method

.method public dump(Lcom/android/internal/util/IndentingPrintWriter;)V
    .locals 5
    .param p1, "pw"    # Lcom/android/internal/util/IndentingPrintWriter;

    .prologue
    .line 504
    invoke-static {}, Lcom/google/android/collect/Lists;->newArrayList()Ljava/util/ArrayList;

    move-result-object v3

    .line 505
    .local v3, "keys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;"
    iget-object v4, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 506
    invoke-static {v3}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 508
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 509
    .local v2, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    const-string v4, "ident="

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(Ljava/lang/String;)V

    iget-object v4, v2, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-virtual {v4}, Lcom/android/server/net/NetworkIdentitySet;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(Ljava/lang/String;)V

    .line 510
    const-string v4, " uid="

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(Ljava/lang/String;)V

    iget v4, v2, Lcom/android/server/net/NetworkStatsCollection$Key;->uid:I

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(I)V

    .line 511
    const-string v4, " set="

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(Ljava/lang/String;)V

    iget v4, v2, Lcom/android/server/net/NetworkStatsCollection$Key;->set:I

    invoke-static {v4}, Landroid/net/NetworkStats;->setToString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(Ljava/lang/String;)V

    .line 512
    const-string v4, " tag="

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->print(Ljava/lang/String;)V

    iget v4, v2, Lcom/android/server/net/NetworkStatsCollection$Key;->tag:I

    invoke-static {v4}, Landroid/net/NetworkStats;->tagToString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Lcom/android/internal/util/IndentingPrintWriter;->println(Ljava/lang/String;)V

    .line 514
    iget-object v4, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v4, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/NetworkStatsHistory;

    .line 515
    .local v0, "history":Landroid/net/NetworkStatsHistory;
    invoke-virtual {p1}, Lcom/android/internal/util/IndentingPrintWriter;->increaseIndent()V

    .line 516
    const/4 v4, 0x1

    invoke-virtual {v0, p1, v4}, Landroid/net/NetworkStatsHistory;->dump(Lcom/android/internal/util/IndentingPrintWriter;Z)V

    .line 517
    invoke-virtual {p1}, Lcom/android/internal/util/IndentingPrintWriter;->decreaseIndent()V

    goto :goto_0

    .line 519
    .end local v0    # "history":Landroid/net/NetworkStatsHistory;
    .end local v2    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_0
    return-void
.end method

.method public getEndMillis()J
    .locals 2

    .prologue
    .line 116
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mEndMillis:J

    return-wide v0
.end method

.method public getFirstAtomicBucketMillis()J
    .locals 4

    .prologue
    const-wide v0, 0x7fffffffffffffffL

    .line 108
    iget-wide v2, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    cmp-long v2, v2, v0

    if-nez v2, :cond_0

    .line 111
    :goto_0
    return-wide v0

    :cond_0
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    iget-wide v2, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    add-long/2addr v0, v2

    goto :goto_0
.end method

.method public getHistory(Landroid/net/NetworkTemplate;IIII)Landroid/net/NetworkStatsHistory;
    .locals 10
    .param p1, "template"    # Landroid/net/NetworkTemplate;
    .param p2, "uid"    # I
    .param p3, "set"    # I
    .param p4, "tag"    # I
    .param p5, "fields"    # I

    .prologue
    .line 141
    const-wide/high16 v6, -0x8000000000000000L

    const-wide v8, 0x7fffffffffffffffL

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v9}, Lcom/android/server/net/NetworkStatsCollection;->getHistory(Landroid/net/NetworkTemplate;IIIIJJ)Landroid/net/NetworkStatsHistory;

    move-result-object v0

    return-object v0
.end method

.method public getHistory(Landroid/net/NetworkTemplate;IIIIJJ)Landroid/net/NetworkStatsHistory;
    .locals 10
    .param p1, "template"    # Landroid/net/NetworkTemplate;
    .param p2, "uid"    # I
    .param p3, "set"    # I
    .param p4, "tag"    # I
    .param p5, "fields"    # I
    .param p6, "start"    # J
    .param p8, "end"    # J

    .prologue
    .line 150
    new-instance v0, Landroid/net/NetworkStatsHistory;

    iget-wide v2, p0, Lcom/android/server/net/NetworkStatsCollection;->mBucketDuration:J

    invoke-direct {p0}, Lcom/android/server/net/NetworkStatsCollection;->estimateBuckets()I

    move-result v1

    invoke-direct {v0, v2, v3, v1, p5}, Landroid/net/NetworkStatsHistory;-><init>(JII)V

    .line 152
    .local v0, "combined":Landroid/net/NetworkStatsHistory;
    iget-object v1, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    .local v7, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    .line 153
    .local v6, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 154
    .local v8, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    const/4 v1, -0x1

    if-eq p3, v1, :cond_1

    iget v1, v8, Lcom/android/server/net/NetworkStatsCollection$Key;->set:I

    if-ne v1, p3, :cond_2

    :cond_1
    const/4 v9, 0x1

    .line 155
    .local v9, "setMatches":Z
    :goto_1
    iget v1, v8, Lcom/android/server/net/NetworkStatsCollection$Key;->uid:I

    if-ne v1, p2, :cond_0

    if-eqz v9, :cond_0

    iget v1, v8, Lcom/android/server/net/NetworkStatsCollection$Key;->tag:I

    if-ne v1, p4, :cond_0

    iget-object v1, v8, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-static {p1, v1}, Lcom/android/server/net/NetworkStatsCollection;->templateMatches(Landroid/net/NetworkTemplate;Lcom/android/server/net/NetworkIdentitySet;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 157
    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/NetworkStatsHistory;

    move-wide/from16 v2, p6

    move-wide/from16 v4, p8

    invoke-virtual/range {v0 .. v5}, Landroid/net/NetworkStatsHistory;->recordHistory(Landroid/net/NetworkStatsHistory;JJ)V

    goto :goto_0

    .line 154
    .end local v9    # "setMatches":Z
    :cond_2
    const/4 v9, 0x0

    goto :goto_1

    .line 160
    .end local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    .end local v8    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_3
    return-object v0
.end method

.method public getStartMillis()J
    .locals 2

    .prologue
    .line 100
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    return-wide v0
.end method

.method public getSummary(Landroid/net/NetworkTemplate;JJ)Landroid/net/NetworkStats;
    .locals 14
    .param p1, "template"    # Landroid/net/NetworkTemplate;
    .param p2, "start"    # J
    .param p4, "end"    # J

    .prologue
    .line 168
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    .line 170
    .local v6, "now":J
    new-instance v12, Landroid/net/NetworkStats;

    sub-long v2, p4, p2

    const/16 v4, 0x18

    invoke-direct {v12, v2, v3, v4}, Landroid/net/NetworkStats;-><init>(JI)V

    .line 171
    .local v12, "stats":Landroid/net/NetworkStats;
    new-instance v0, Landroid/net/NetworkStats$Entry;

    invoke-direct {v0}, Landroid/net/NetworkStats$Entry;-><init>()V

    .line 172
    .local v0, "entry":Landroid/net/NetworkStats$Entry;
    const/4 v8, 0x0

    .line 175
    .local v8, "historyEntry":Landroid/net/NetworkStatsHistory$Entry;
    cmp-long v2, p2, p4

    if-nez v2, :cond_1

    .line 199
    :cond_0
    return-object v12

    .line 177
    :cond_1
    iget-object v2, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    .local v9, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/util/Map$Entry;

    .line 178
    .local v11, "mapEntry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    invoke-interface {v11}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 179
    .local v10, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v2, v10, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-static {p1, v2}, Lcom/android/server/net/NetworkStatsCollection;->templateMatches(Landroid/net/NetworkTemplate;Lcom/android/server/net/NetworkIdentitySet;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 180
    invoke-interface {v11}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/NetworkStatsHistory;

    .local v1, "history":Landroid/net/NetworkStatsHistory;
    move-wide/from16 v2, p2

    move-wide/from16 v4, p4

    .line 181
    invoke-virtual/range {v1 .. v8}, Landroid/net/NetworkStatsHistory;->getValues(JJJLandroid/net/NetworkStatsHistory$Entry;)Landroid/net/NetworkStatsHistory$Entry;

    move-result-object v8

    .line 183
    sget-object v2, Landroid/net/NetworkStats;->IFACE_ALL:Ljava/lang/String;

    iput-object v2, v0, Landroid/net/NetworkStats$Entry;->iface:Ljava/lang/String;

    .line 184
    iget v2, v10, Lcom/android/server/net/NetworkStatsCollection$Key;->uid:I

    iput v2, v0, Landroid/net/NetworkStats$Entry;->uid:I

    .line 185
    iget v2, v10, Lcom/android/server/net/NetworkStatsCollection$Key;->set:I

    iput v2, v0, Landroid/net/NetworkStats$Entry;->set:I

    .line 186
    iget v2, v10, Lcom/android/server/net/NetworkStatsCollection$Key;->tag:I

    iput v2, v0, Landroid/net/NetworkStats$Entry;->tag:I

    .line 187
    iget-wide v2, v8, Landroid/net/NetworkStatsHistory$Entry;->rxBytes:J

    iput-wide v2, v0, Landroid/net/NetworkStats$Entry;->rxBytes:J

    .line 188
    iget-wide v2, v8, Landroid/net/NetworkStatsHistory$Entry;->rxPackets:J

    iput-wide v2, v0, Landroid/net/NetworkStats$Entry;->rxPackets:J

    .line 189
    iget-wide v2, v8, Landroid/net/NetworkStatsHistory$Entry;->txBytes:J

    iput-wide v2, v0, Landroid/net/NetworkStats$Entry;->txBytes:J

    .line 190
    iget-wide v2, v8, Landroid/net/NetworkStatsHistory$Entry;->txPackets:J

    iput-wide v2, v0, Landroid/net/NetworkStats$Entry;->txPackets:J

    .line 191
    iget-wide v2, v8, Landroid/net/NetworkStatsHistory$Entry;->operations:J

    iput-wide v2, v0, Landroid/net/NetworkStats$Entry;->operations:J

    .line 193
    invoke-virtual {v0}, Landroid/net/NetworkStats$Entry;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_2

    .line 194
    invoke-virtual {v12, v0}, Landroid/net/NetworkStats;->combineValues(Landroid/net/NetworkStats$Entry;)Landroid/net/NetworkStats;

    goto :goto_0
.end method

.method public getTotalBytes()J
    .locals 2

    .prologue
    .line 120
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mTotalBytes:J

    return-wide v0
.end method

.method public getUids(Landroid/net/NetworkTemplate;)[I
    .locals 5
    .param p1, "template"    # Landroid/net/NetworkTemplate;

    .prologue
    .line 436
    const/4 v4, 0x0

    new-array v3, v4, [I

    .line 437
    .local v3, "uids":[I
    iget-object v4, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 438
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 439
    .local v2, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v4, v2, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-static {p1, v4}, Lcom/android/server/net/NetworkStatsCollection;->templateMatches(Landroid/net/NetworkTemplate;Lcom/android/server/net/NetworkIdentitySet;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 440
    iget v4, v2, Lcom/android/server/net/NetworkStatsCollection$Key;->uid:I

    invoke-static {v3, v4}, Lcom/android/internal/util/ArrayUtils;->appendInt([II)[I

    move-result-object v3

    goto :goto_0

    .line 443
    .end local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    .end local v2    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_1
    return-object v3
.end method

.method public isDirty()Z
    .locals 1

    .prologue
    .line 124
    iget-boolean v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mDirty:Z

    return v0
.end method

.method public isEmpty()Z
    .locals 4

    .prologue
    .line 132
    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    const-wide v2, 0x7fffffffffffffffL

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mEndMillis:J

    const-wide/high16 v2, -0x8000000000000000L

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public read(Ljava/io/DataInputStream;)V
    .locals 16
    .param p1, "in"    # Ljava/io/DataInputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 265
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v7

    .line 266
    .local v7, "magic":I
    const v13, 0x414e4554

    if-eq v7, v13, :cond_0

    .line 267
    new-instance v13, Ljava/net/ProtocolException;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "unexpected magic: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-direct {v13, v14}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 270
    :cond_0
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v12

    .line 271
    .local v12, "version":I
    packed-switch v12, :pswitch_data_0

    .line 292
    new-instance v13, Ljava/net/ProtocolException;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "unexpected version: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-direct {v13, v14}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 274
    :pswitch_0
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v4

    .line 275
    .local v4, "identSize":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v4, :cond_2

    .line 276
    new-instance v3, Lcom/android/server/net/NetworkIdentitySet;

    move-object/from16 v0, p1

    invoke-direct {v3, v0}, Lcom/android/server/net/NetworkIdentitySet;-><init>(Ljava/io/DataInputStream;)V

    .line 278
    .local v3, "ident":Lcom/android/server/net/NetworkIdentitySet;
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v9

    .line 279
    .local v9, "size":I
    const/4 v5, 0x0

    .local v5, "j":I
    :goto_1
    if-ge v5, v9, :cond_1

    .line 280
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v11

    .line 281
    .local v11, "uid":I
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v8

    .line 282
    .local v8, "set":I
    invoke-virtual/range {p1 .. p1}, Ljava/io/DataInputStream;->readInt()I

    move-result v10

    .line 284
    .local v10, "tag":I
    new-instance v6, Lcom/android/server/net/NetworkStatsCollection$Key;

    invoke-direct {v6, v3, v11, v8, v10}, Lcom/android/server/net/NetworkStatsCollection$Key;-><init>(Lcom/android/server/net/NetworkIdentitySet;III)V

    .line 285
    .local v6, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    new-instance v1, Landroid/net/NetworkStatsHistory;

    move-object/from16 v0, p1

    invoke-direct {v1, v0}, Landroid/net/NetworkStatsHistory;-><init>(Ljava/io/DataInputStream;)V

    .line 286
    .local v1, "history":Landroid/net/NetworkStatsHistory;
    move-object/from16 v0, p0

    invoke-direct {v0, v6, v1}, Lcom/android/server/net/NetworkStatsCollection;->recordHistory(Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;)V

    .line 279
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 275
    .end local v1    # "history":Landroid/net/NetworkStatsHistory;
    .end local v6    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    .end local v8    # "set":I
    .end local v10    # "tag":I
    .end local v11    # "uid":I
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 295
    .end local v3    # "ident":Lcom/android/server/net/NetworkIdentitySet;
    .end local v5    # "j":I
    .end local v9    # "size":I
    :cond_2
    return-void

    .line 271
    nop

    :pswitch_data_0
    .packed-switch 0x10
        :pswitch_0
    .end packed-switch
.end method

.method public read(Ljava/io/InputStream;)V
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 260
    new-instance v0, Ljava/io/DataInputStream;

    invoke-direct {v0, p1}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-virtual {p0, v0}, Lcom/android/server/net/NetworkStatsCollection;->read(Ljava/io/DataInputStream;)V

    .line 261
    return-void
.end method

.method public readLegacyNetwork(Ljava/io/File;)V
    .locals 13
    .param p1, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 332
    new-instance v5, Landroid/util/AtomicFile;

    invoke-direct {v5, p1}, Landroid/util/AtomicFile;-><init>(Ljava/io/File;)V

    .line 334
    .local v5, "inputFile":Landroid/util/AtomicFile;
    const/4 v3, 0x0

    .line 336
    .local v3, "in":Ljava/io/DataInputStream;
    :try_start_0
    new-instance v4, Ljava/io/DataInputStream;

    new-instance v10, Ljava/io/BufferedInputStream;

    invoke-virtual {v5}, Landroid/util/AtomicFile;->openRead()Ljava/io/FileInputStream;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v4, v10}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 339
    .end local v3    # "in":Ljava/io/DataInputStream;
    .local v4, "in":Ljava/io/DataInputStream;
    :try_start_1
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readInt()I

    move-result v7

    .line 340
    .local v7, "magic":I
    const v10, 0x414e4554

    if-eq v7, v10, :cond_0

    .line 341
    new-instance v10, Ljava/net/ProtocolException;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "unexpected magic: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v10
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 362
    .end local v7    # "magic":I
    :catch_0
    move-exception v10

    move-object v3, v4

    .line 365
    .end local v4    # "in":Ljava/io/DataInputStream;
    .restart local v3    # "in":Ljava/io/DataInputStream;
    :goto_0
    invoke-static {v3}, Llibcore/io/IoUtils;->closeQuietly(Ljava/lang/AutoCloseable;)V

    .line 367
    :goto_1
    return-void

    .line 344
    .end local v3    # "in":Ljava/io/DataInputStream;
    .restart local v4    # "in":Ljava/io/DataInputStream;
    .restart local v7    # "magic":I
    :cond_0
    :try_start_2
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readInt()I

    move-result v9

    .line 345
    .local v9, "version":I
    packed-switch v9, :pswitch_data_0

    .line 359
    new-instance v10, Ljava/net/ProtocolException;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "unexpected version: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v10
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 365
    .end local v7    # "magic":I
    .end local v9    # "version":I
    :catchall_0
    move-exception v10

    move-object v3, v4

    .end local v4    # "in":Ljava/io/DataInputStream;
    .restart local v3    # "in":Ljava/io/DataInputStream;
    :goto_2
    invoke-static {v3}, Llibcore/io/IoUtils;->closeQuietly(Ljava/lang/AutoCloseable;)V

    throw v10

    .line 348
    .end local v3    # "in":Ljava/io/DataInputStream;
    .restart local v4    # "in":Ljava/io/DataInputStream;
    .restart local v7    # "magic":I
    .restart local v9    # "version":I
    :pswitch_0
    :try_start_3
    invoke-virtual {v4}, Ljava/io/DataInputStream;->readInt()I

    move-result v8

    .line 349
    .local v8, "size":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_3
    if-ge v1, v8, :cond_1

    .line 350
    new-instance v2, Lcom/android/server/net/NetworkIdentitySet;

    invoke-direct {v2, v4}, Lcom/android/server/net/NetworkIdentitySet;-><init>(Ljava/io/DataInputStream;)V

    .line 351
    .local v2, "ident":Lcom/android/server/net/NetworkIdentitySet;
    new-instance v0, Landroid/net/NetworkStatsHistory;

    invoke-direct {v0, v4}, Landroid/net/NetworkStatsHistory;-><init>(Ljava/io/DataInputStream;)V

    .line 353
    .local v0, "history":Landroid/net/NetworkStatsHistory;
    new-instance v6, Lcom/android/server/net/NetworkStatsCollection$Key;

    const/4 v10, -0x1

    const/4 v11, -0x1

    const/4 v12, 0x0

    invoke-direct {v6, v2, v10, v11, v12}, Lcom/android/server/net/NetworkStatsCollection$Key;-><init>(Lcom/android/server/net/NetworkIdentitySet;III)V

    .line 354
    .local v6, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    invoke-direct {p0, v6, v0}, Lcom/android/server/net/NetworkStatsCollection;->recordHistory(Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;)V
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 349
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 365
    .end local v0    # "history":Landroid/net/NetworkStatsHistory;
    .end local v2    # "ident":Lcom/android/server/net/NetworkIdentitySet;
    .end local v6    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_1
    invoke-static {v4}, Llibcore/io/IoUtils;->closeQuietly(Ljava/lang/AutoCloseable;)V

    move-object v3, v4

    .line 366
    .end local v4    # "in":Ljava/io/DataInputStream;
    .restart local v3    # "in":Ljava/io/DataInputStream;
    goto :goto_1

    .line 365
    .end local v1    # "i":I
    .end local v7    # "magic":I
    .end local v8    # "size":I
    .end local v9    # "version":I
    :catchall_1
    move-exception v10

    goto :goto_2

    .line 362
    :catch_1
    move-exception v10

    goto :goto_0

    .line 345
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method public readLegacyUid(Ljava/io/File;Z)V
    .locals 20
    .param p1, "file"    # Ljava/io/File;
    .param p2, "onlyTags"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 371
    new-instance v8, Landroid/util/AtomicFile;

    move-object/from16 v0, p1

    invoke-direct {v8, v0}, Landroid/util/AtomicFile;-><init>(Ljava/io/File;)V

    .line 373
    .local v8, "inputFile":Landroid/util/AtomicFile;
    const/4 v6, 0x0

    .line 375
    .local v6, "in":Ljava/io/DataInputStream;
    :try_start_0
    new-instance v7, Ljava/io/DataInputStream;

    new-instance v17, Ljava/io/BufferedInputStream;

    invoke-virtual {v8}, Landroid/util/AtomicFile;->openRead()Ljava/io/FileInputStream;

    move-result-object v18

    invoke-direct/range {v17 .. v18}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object/from16 v0, v17

    invoke-direct {v7, v0}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 378
    .end local v6    # "in":Ljava/io/DataInputStream;
    .local v7, "in":Ljava/io/DataInputStream;
    :try_start_1
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v11

    .line 379
    .local v11, "magic":I
    const v17, 0x414e4554

    move/from16 v0, v17

    if-eq v11, v0, :cond_0

    .line 380
    new-instance v17, Ljava/net/ProtocolException;

    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "unexpected magic: "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    invoke-direct/range {v17 .. v18}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v17
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 427
    .end local v11    # "magic":I
    :catch_0
    move-exception v17

    move-object v6, v7

    .line 430
    .end local v7    # "in":Ljava/io/DataInputStream;
    .restart local v6    # "in":Ljava/io/DataInputStream;
    :goto_0
    invoke-static {v6}, Llibcore/io/IoUtils;->closeQuietly(Ljava/lang/AutoCloseable;)V

    .line 432
    :goto_1
    return-void

    .line 383
    .end local v6    # "in":Ljava/io/DataInputStream;
    .restart local v7    # "in":Ljava/io/DataInputStream;
    .restart local v11    # "magic":I
    :cond_0
    :try_start_2
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v16

    .line 384
    .local v16, "version":I
    packed-switch v16, :pswitch_data_0

    .line 424
    new-instance v17, Ljava/net/ProtocolException;

    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "unexpected version: "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    invoke-direct/range {v17 .. v18}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v17
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 430
    .end local v11    # "magic":I
    .end local v16    # "version":I
    :catchall_0
    move-exception v17

    move-object v6, v7

    .end local v7    # "in":Ljava/io/DataInputStream;
    .restart local v6    # "in":Ljava/io/DataInputStream;
    :goto_2
    invoke-static {v6}, Llibcore/io/IoUtils;->closeQuietly(Ljava/lang/AutoCloseable;)V

    throw v17

    .line 402
    .end local v6    # "in":Ljava/io/DataInputStream;
    .restart local v7    # "in":Ljava/io/DataInputStream;
    .restart local v11    # "magic":I
    .restart local v16    # "version":I
    :pswitch_0
    :try_start_3
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v5

    .line 403
    .local v5, "identSize":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_3
    if-ge v3, v5, :cond_5

    .line 404
    new-instance v4, Lcom/android/server/net/NetworkIdentitySet;

    invoke-direct {v4, v7}, Lcom/android/server/net/NetworkIdentitySet;-><init>(Ljava/io/DataInputStream;)V

    .line 406
    .local v4, "ident":Lcom/android/server/net/NetworkIdentitySet;
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v13

    .line 407
    .local v13, "size":I
    const/4 v9, 0x0

    .local v9, "j":I
    :goto_4
    if-ge v9, v13, :cond_4

    .line 408
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v15

    .line 409
    .local v15, "uid":I
    const/16 v17, 0x4

    move/from16 v0, v16

    move/from16 v1, v17

    if-lt v0, v1, :cond_2

    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v12

    .line 411
    .local v12, "set":I
    :goto_5
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readInt()I

    move-result v14

    .line 413
    .local v14, "tag":I
    new-instance v10, Lcom/android/server/net/NetworkStatsCollection$Key;

    invoke-direct {v10, v4, v15, v12, v14}, Lcom/android/server/net/NetworkStatsCollection$Key;-><init>(Lcom/android/server/net/NetworkIdentitySet;III)V

    .line 414
    .local v10, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    new-instance v2, Landroid/net/NetworkStatsHistory;

    invoke-direct {v2, v7}, Landroid/net/NetworkStatsHistory;-><init>(Ljava/io/DataInputStream;)V

    .line 416
    .local v2, "history":Landroid/net/NetworkStatsHistory;
    if-nez v14, :cond_3

    const/16 v17, 0x1

    :goto_6
    move/from16 v0, v17

    move/from16 v1, p2

    if-eq v0, v1, :cond_1

    .line 417
    move-object/from16 v0, p0

    invoke-direct {v0, v10, v2}, Lcom/android/server/net/NetworkStatsCollection;->recordHistory(Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;)V
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 407
    :cond_1
    add-int/lit8 v9, v9, 0x1

    goto :goto_4

    .line 409
    .end local v2    # "history":Landroid/net/NetworkStatsHistory;
    .end local v10    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    .end local v12    # "set":I
    .end local v14    # "tag":I
    :cond_2
    const/4 v12, 0x0

    goto :goto_5

    .line 416
    .restart local v2    # "history":Landroid/net/NetworkStatsHistory;
    .restart local v10    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    .restart local v12    # "set":I
    .restart local v14    # "tag":I
    :cond_3
    const/16 v17, 0x0

    goto :goto_6

    .line 403
    .end local v2    # "history":Landroid/net/NetworkStatsHistory;
    .end local v10    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    .end local v12    # "set":I
    .end local v14    # "tag":I
    .end local v15    # "uid":I
    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 430
    .end local v3    # "i":I
    .end local v4    # "ident":Lcom/android/server/net/NetworkIdentitySet;
    .end local v5    # "identSize":I
    .end local v9    # "j":I
    .end local v13    # "size":I
    :cond_5
    :pswitch_1
    invoke-static {v7}, Llibcore/io/IoUtils;->closeQuietly(Ljava/lang/AutoCloseable;)V

    move-object v6, v7

    .line 431
    .end local v7    # "in":Ljava/io/DataInputStream;
    .restart local v6    # "in":Ljava/io/DataInputStream;
    goto :goto_1

    .line 430
    .end local v11    # "magic":I
    .end local v16    # "version":I
    :catchall_1
    move-exception v17

    goto :goto_2

    .line 427
    :catch_1
    move-exception v17

    goto/16 :goto_0

    .line 384
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public recordCollection(Lcom/android/server/net/NetworkStatsCollection;)V
    .locals 4
    .param p1, "another"    # Lcom/android/server/net/NetworkStatsCollection;

    .prologue
    .line 232
    iget-object v2, p1, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 233
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/net/NetworkStatsCollection$Key;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/NetworkStatsHistory;

    invoke-direct {p0, v2, v3}, Lcom/android/server/net/NetworkStatsCollection;->recordHistory(Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;)V

    goto :goto_0

    .line 235
    .end local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/android/server/net/NetworkStatsCollection$Key;Landroid/net/NetworkStatsHistory;>;"
    :cond_0
    return-void
.end method

.method public recordData(Lcom/android/server/net/NetworkIdentitySet;IIIJJLandroid/net/NetworkStats$Entry;)V
    .locals 13
    .param p1, "ident"    # Lcom/android/server/net/NetworkIdentitySet;
    .param p2, "uid"    # I
    .param p3, "set"    # I
    .param p4, "tag"    # I
    .param p5, "start"    # J
    .param p7, "end"    # J
    .param p9, "entry"    # Landroid/net/NetworkStats$Entry;

    .prologue
    .line 207
    invoke-direct/range {p0 .. p4}, Lcom/android/server/net/NetworkStatsCollection;->findOrCreateHistory(Lcom/android/server/net/NetworkIdentitySet;III)Landroid/net/NetworkStatsHistory;

    move-result-object v3

    .local v3, "history":Landroid/net/NetworkStatsHistory;
    move-wide/from16 v4, p5

    move-wide/from16 v6, p7

    move-object/from16 v8, p9

    .line 208
    invoke-virtual/range {v3 .. v8}, Landroid/net/NetworkStatsHistory;->recordData(JJLandroid/net/NetworkStats$Entry;)V

    .line 209
    invoke-virtual {v3}, Landroid/net/NetworkStatsHistory;->getStart()J

    move-result-wide v6

    invoke-virtual {v3}, Landroid/net/NetworkStatsHistory;->getEnd()J

    move-result-wide v8

    move-object/from16 v0, p9

    iget-wide v4, v0, Landroid/net/NetworkStats$Entry;->rxBytes:J

    move-object/from16 v0, p9

    iget-wide v10, v0, Landroid/net/NetworkStats$Entry;->txBytes:J

    add-long/2addr v10, v4

    move-object v5, p0

    invoke-direct/range {v5 .. v11}, Lcom/android/server/net/NetworkStatsCollection;->noteRecordedHistory(JJJ)V

    .line 210
    return-void
.end method

.method public removeUids([I)V
    .locals 8
    .param p1, "uids"    # [I

    .prologue
    const/4 v7, 0x0

    .line 472
    invoke-static {}, Lcom/google/android/collect/Lists;->newArrayList()Ljava/util/ArrayList;

    move-result-object v2

    .line 473
    .local v2, "knownKeys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;"
    iget-object v5, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 476
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 477
    .local v1, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget v5, v1, Lcom/android/server/net/NetworkStatsCollection$Key;->uid:I

    invoke-static {p1, v5}, Lcom/android/internal/util/ArrayUtils;->contains([II)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 479
    iget v5, v1, Lcom/android/server/net/NetworkStatsCollection$Key;->tag:I

    if-nez v5, :cond_1

    .line 480
    iget-object v5, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v5, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/NetworkStatsHistory;

    .line 481
    .local v4, "uidHistory":Landroid/net/NetworkStatsHistory;
    iget-object v5, v1, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    const/4 v6, -0x4

    invoke-direct {p0, v5, v6, v7, v7}, Lcom/android/server/net/NetworkStatsCollection;->findOrCreateHistory(Lcom/android/server/net/NetworkIdentitySet;III)Landroid/net/NetworkStatsHistory;

    move-result-object v3

    .line 483
    .local v3, "removedHistory":Landroid/net/NetworkStatsHistory;
    invoke-virtual {v3, v4}, Landroid/net/NetworkStatsHistory;->recordEntireHistory(Landroid/net/NetworkStatsHistory;)V

    .line 485
    .end local v3    # "removedHistory":Landroid/net/NetworkStatsHistory;
    .end local v4    # "uidHistory":Landroid/net/NetworkStatsHistory;
    :cond_1
    iget-object v5, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v5, v1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 486
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/android/server/net/NetworkStatsCollection;->mDirty:Z

    goto :goto_0

    .line 489
    .end local v1    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    :cond_2
    return-void
.end method

.method public reset()V
    .locals 2

    .prologue
    .line 92
    iget-object v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 93
    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mStartMillis:J

    .line 94
    const-wide/high16 v0, -0x8000000000000000L

    iput-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mEndMillis:J

    .line 95
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mTotalBytes:J

    .line 96
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/net/NetworkStatsCollection;->mDirty:Z

    .line 97
    return-void
.end method

.method public write(Ljava/io/DataOutputStream;)V
    .locals 8
    .param p1, "out"    # Ljava/io/DataOutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 299
    invoke-static {}, Lcom/google/android/collect/Maps;->newHashMap()Ljava/util/HashMap;

    move-result-object v6

    .line 300
    .local v6, "keysByIdent":Ljava/util/HashMap;, "Ljava/util/HashMap<Lcom/android/server/net/NetworkIdentitySet;Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;>;"
    iget-object v7, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v7}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 301
    .local v4, "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v7, v4, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-virtual {v6, v7}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/ArrayList;

    .line 302
    .local v5, "keys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;"
    if-nez v5, :cond_0

    .line 303
    invoke-static {}, Lcom/google/android/collect/Lists;->newArrayList()Ljava/util/ArrayList;

    move-result-object v5

    .line 304
    iget-object v7, v4, Lcom/android/server/net/NetworkStatsCollection$Key;->ident:Lcom/android/server/net/NetworkIdentitySet;

    invoke-virtual {v6, v7, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 306
    :cond_0
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 309
    .end local v4    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    .end local v5    # "keys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;"
    :cond_1
    const v7, 0x414e4554

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 310
    const/16 v7, 0x10

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 312
    invoke-virtual {v6}, Ljava/util/HashMap;->size()I

    move-result v7

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 313
    invoke-virtual {v6}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/net/NetworkIdentitySet;

    .line 314
    .local v3, "ident":Lcom/android/server/net/NetworkIdentitySet;
    invoke-virtual {v6, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/ArrayList;

    .line 315
    .restart local v5    # "keys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;"
    invoke-virtual {v3, p1}, Lcom/android/server/net/NetworkIdentitySet;->writeToStream(Ljava/io/DataOutputStream;)V

    .line 317
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v7

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 318
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/net/NetworkStatsCollection$Key;

    .line 319
    .restart local v4    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    iget-object v7, p0, Lcom/android/server/net/NetworkStatsCollection;->mStats:Ljava/util/HashMap;

    invoke-virtual {v7, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/NetworkStatsHistory;

    .line 320
    .local v0, "history":Landroid/net/NetworkStatsHistory;
    iget v7, v4, Lcom/android/server/net/NetworkStatsCollection$Key;->uid:I

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 321
    iget v7, v4, Lcom/android/server/net/NetworkStatsCollection$Key;->set:I

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 322
    iget v7, v4, Lcom/android/server/net/NetworkStatsCollection$Key;->tag:I

    invoke-virtual {p1, v7}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 323
    invoke-virtual {v0, p1}, Landroid/net/NetworkStatsHistory;->writeToStream(Ljava/io/DataOutputStream;)V

    goto :goto_1

    .line 327
    .end local v0    # "history":Landroid/net/NetworkStatsHistory;
    .end local v2    # "i$":Ljava/util/Iterator;
    .end local v3    # "ident":Lcom/android/server/net/NetworkIdentitySet;
    .end local v4    # "key":Lcom/android/server/net/NetworkStatsCollection$Key;
    .end local v5    # "keys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/server/net/NetworkStatsCollection$Key;>;"
    :cond_3
    invoke-virtual {p1}, Ljava/io/DataOutputStream;->flush()V

    .line 328
    return-void
.end method