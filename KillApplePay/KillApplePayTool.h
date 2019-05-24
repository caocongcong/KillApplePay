//
//  KillApplePayTool.h
//  KillApplePay
//
//  Created by ccc's MacBook Pro on 2019/5/23.
//  Copyright © 2019 CCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KillApplePayTool : NSObject

/**
 禁用Apple Pay

 @param vc 需要禁用的页面
 */
+ (void)killApplePay:(UIViewController *)vc;

/**
 允许Apple Pay
 
 @param vc 需要允许使用的页面
 */
+ (void)reviveApplePay:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
