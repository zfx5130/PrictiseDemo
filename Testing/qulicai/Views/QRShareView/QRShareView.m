//
//  QRShareView.m
//  qulicai
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRShareView.h"
#import "QRShareHelper.h"
#import <MessageUI/MessageUI.h>
#import "QRMessageComposeViewController.h"
#import "WXZTipView.h"
#import <SGQRCodeGenerateManager.h>
#import "UserUtil.h"
#import "User.h"

@interface QRShareView () <MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) MFMessageComposeViewController *messageController;

@end

@implementation QRShareView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        self.aView.frame = frame;
        [self addSubview:self.aView];
        [self setupQrImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - Setters && Getters

- (void)setupQrImageView {
    NSString *url =
    [NSString stringWithFormat:@"http://h5.qulicai8.com:3478/qlc_jumpShareRegister.html?type=0&uid=%@",[UserUtil currentUser].userId];
    self.qrCodeImageView.image =
    [SGQRCodeGenerateManager generateWithLogoQRCodeData:url
                                          logoImageName:@"about_logo_image"
                                   logoScaleToSuperView:.2f];
}

#pragma mark - Pirvate

- (IBAction)shareButtonWasPressed:(UIButton *)sender {
    QRShareHelper *shareHelper = [[QRShareHelper alloc] init];
    if (self.zhPopController) {
        [self.zhPopController dismiss];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switch (sender.tag) {
            case 1: {
                [shareHelper qr_shareWithType:QRShareTypeWeChat];
            }
                break;
            case 2: {
                [shareHelper qr_shareWithType:QRShareTypeWeChatMoments];
            }
                break;
            case 3: {
                [shareHelper qr_shareWithType:QRShareTypeQQ];
            }
                break;
            case 4: {
                [shareHelper qr_shareWithType:QRShareTypeQQZone];
            }
                break;
            case 5: {
                [self qr_shareAddressBook];
            }
                break;
            case 6: {
            }
                break;
            default:
                break;
        }
    });
}

#pragma mark - Address book

- (void)qr_shareAddressBook {
    NSLog(@"--通讯录分享---");
    if([MFMessageComposeViewController canSendText]) {
        QRMessageComposeViewController *controller = [[QRMessageComposeViewController alloc] init];
        controller.recipients = nil;
        controller.body = @"趣融金服旗下信用贷款信息中介平台";
        controller.messageComposeDelegate = self;
        [self.currentController presentViewController:controller animated:YES completion:^{}];
    } else {
        [WXZTipView showCenterWithText:@"该设备不支持短信功能"];
    }
}

#pragma mark -MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    [self.currentController dismissViewControllerAnimated:NO
                                               completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            [WXZTipView showCenterWithText:@"发送成功"];
            break;
        case MessageComposeResultFailed:
            [WXZTipView showCenterWithText:@"发送失败"];
            break;
        case MessageComposeResultCancelled:
            [WXZTipView showCenterWithText:@"发送取消"];
            break;
        default:
            break;
    }
    
}

@end
