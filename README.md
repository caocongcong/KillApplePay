# KillApplePay

#####禁用Apple Pay

⚠️没有用到私有API，不会影响app store审核



#####什么是Apple Pay：

*Apple Pay*，是苹果公司在2014苹果秋季新品发布会上发布的一种基于NFC的手机支付功能。当苹果手机靠近NFC设备时，屏幕最顶层就会弹出支付页面



#####背景：

小恩公司主要业务为提供二维码给地铁闸机扫码开闸，有一天，小C接到一个反馈说用户在手机靠近闸机时，弹出了Apple Pay页面，遮挡住了手机屏幕上的二维码，导致扫码失败。于是小恩就去查资料想要禁用Apple Pay，可是查遍了所有资料都没有发现苹果有任何关于Apple Pay开放的API，小恩感到很失望。过了一段时间，小恩在玩手机时，发现某app的会员卡可以添加到手机的“Wallet”app中，会员卡的添加页面貌似与Apple Pay的支付页面极其相似。突然小恩好像发现了什么。。。😜



#####原理：

iOS并没有开放的API可以在应用内禁止Apple Pay页面的弹出。要做到除非研究苹果的私有API，但是很容易导致审核被拒。

Apple Pay弹出的页面为系统app“Wallet”中的绑卡列表页面，“Wallet”还有另外一种类似”卡券“的页面，并且“卡券”页面是可以在app内主动唤起的，但是Apple Pay的支付页面是只能被动唤起的；如果在app内主动唤起一个卡券页面，那么Apple Pay的支付页面还能被唤起吗？

经过测试，当app中已经存在“卡券”添加页面，就不会在弹起Apple Pay的支付页面了，这应该是苹果自己的机制

那么，只需要把“卡券”页面添加到页面中，并将其隐藏就OK了。

![](./real.png)



```
- (void)viewDidLoad {
    [super viewDidLoad];
    [KillApplePayTool killApplePay:self];
}
```



#####示例

经过测试，app在前后台切换的时候，有几率会导致添加的“卡券”页面失效，无法再次禁用Apple Pay

所以建议用以下方式：

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_kill) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_revive) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self p_kill];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self p_revive];
}

- (void)p_kill {
    [KillApplePayTool killApplePay:self];
}

- (void)p_revive {
    [KillApplePayTool reviveApplePay:self];
}
```



##### Q&A

卡券页面的主要依赖一个文件.pkpass，[如何制作](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/YourFirst.html#//apple_ref/doc/uid/TP40012195-CH2-SW1)？