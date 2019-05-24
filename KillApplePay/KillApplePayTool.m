//
//  KillApplePayTool.m
//  KillApplePay
//
//  Created by ccc's MacBook Pro on 2019/5/23.
//  Copyright © 2019 CCC. All rights reserved.
//

#import "KillApplePayTool.h"
#import <PassKit/PassKit.h>

@implementation KillApplePayTool

+ (void)killApplePay:(UIViewController *)vc {
    NSString *passFile = [[NSBundle mainBundle] pathForResource:@"applepay" ofType:@"pkpass"];
    if (!passFile) {
        return;
    }
    NSData *passData = [NSData dataWithContentsOfFile:passFile];
    if (!passData) {
        return;
    }
    
    NSError *error = nil;
    PKPass *newPass = [[PKPass alloc] initWithData:passData
                                             error:&error];
    if (!newPass) {
        return;
    }
    
    PKAddPassesViewController *addController = [[PKAddPassesViewController alloc] initWithPass:newPass];
    if (!addController) {
        return;
    }
    addController.view.hidden = YES;
    [vc addChildViewController:addController];
}

+ (void)reviveApplePay:(UIViewController *)vc {
    for (UIViewController *item in vc.childViewControllers) {
        if ([item isKindOfClass:[PKAddPassesViewController class]]) {
            [item removeFromParentViewController];
            break;
        }
    }
}

@end
