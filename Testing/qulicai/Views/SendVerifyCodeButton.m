//
//  SenderVerifyButton.m
//  SenderVerifyCode
//
//  Created by dev on 15/9/24.
//  Copyright © 2015年 dev. All rights reserved.
//

NSString *const kSendVerifyCodeTime = @"kSendVerifyCodeTime";
NSString *const kAcceptVerifyCodePhone = @"kAcceptVerifyCodePhone";

#define UserDefaultsValue(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define TIME_INTERVAL_NOW (long long)[[NSDate date] timeIntervalSince1970]
#define UserDefaultsSave(key, value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

static const NSUInteger kVerifyCodeDuration = 60;

#import "SendVerifyCodeButton.h"

@interface SendVerifyCodeButton ()

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) BOOL isBankCode;

@end

@implementation SendVerifyCodeButton

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
      //  [self setTitle:@"获取验证码>"
      //        forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - Public

- (void)sendVerifyCodeWithPhone:(NSString *)phone
                     isBankCode:(BOOL)isBankCode {
    UserDefaultsSave(kSendVerifyCodeTime, @(TIME_INTERVAL_NOW));
    UserDefaultsSave(kAcceptVerifyCodePhone, phone);
    self.isBankCode = isBankCode;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(updateState)
                                                userInfo:nil
                                                 repeats:YES];
}

- (BOOL)canSenderVerifyCodeWithPhone:(NSString *)phone {
    long long currentTime = TIME_INTERVAL_NOW;
    long long senderVerifyCodeTime = [UserDefaultsValue(kSendVerifyCodeTime) longLongValue];
    NSString *locationPhone = UserDefaultsValue(kAcceptVerifyCodePhone);
    if ([locationPhone isEqualToString:phone]) {
        long long timeInterval = currentTime - senderVerifyCodeTime;
        if (timeInterval < kVerifyCodeDuration) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                          target:self
                                                        selector:@selector(updateState)
                                                        userInfo:nil
                                                         repeats:YES];
            return YES;
        }
        self.userInteractionEnabled = timeInterval >= kVerifyCodeDuration;
    }
    return NO;
}

#pragma mark - Handlers

- (void)updateState {
    long long currentTime = TIME_INTERVAL_NOW;
    long long senderVerifyCodeTime = [[[NSUserDefaults standardUserDefaults] objectForKey:kSendVerifyCodeTime] longLongValue];
    long long timeInterval = currentTime - senderVerifyCodeTime;
    if (timeInterval < kVerifyCodeDuration) {
        NSString *str = self.isBankCode ? @"后重新发送" : @"后重新获取";
        NSString *text = [NSString stringWithFormat:@"%@s%@",@(kVerifyCodeDuration - timeInterval), str];
        self.titleLabel.text = text;
        [self setTitle:text
              forState:UIControlStateNormal];
        [self setTitleColor:RGBColor(204, 204, 204)
                   forState:UIControlStateNormal];

    } else {
        [self.timer invalidate];
        NSString *title = self.isBankCode ? @"重新获取验证码" : @"获取验证码>";
        [self setTitle:title
              forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        UserDefaultsRemove(kSendVerifyCodeTime);
        UserDefaultsRemove(kAcceptVerifyCodePhone);
        [self setTitleColor:RGBColor(113, 175, 255)
                   forState:UIControlStateNormal];
    }
}

@end
