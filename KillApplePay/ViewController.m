//
//  ViewController.m
//  KillApplePay
//
//  Created by ccc's MacBook Pro on 2019/5/23.
//  Copyright © 2019 CCC. All rights reserved.
//

#import "ViewController.h"
#import "KillApplePayTool.h"

@interface ViewController ()

@end

@implementation ViewController

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

@end
