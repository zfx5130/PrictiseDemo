//
//  Macro.h
//  qulicai
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 qurong. All rights reserved.
//

#ifndef bike_Macro_h
#define bike_Macro_h

#pragma mark - App

#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

#pragma mark - Vendors

#pragma mark - NSUserDefaults

#define UserDefaults [NSUserDefaults standardUserDefaults]
#define UserDefaultsValue(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define UserDefaultsSet(key, value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define UserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
#define UserDefaultsSave(key, value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

#pragma mark - Notification Center

#define PostNotification(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
#define PostNotificationWithUseInfo(name, userInfo) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];

#define AddNotificationCenter(selectorName, postName)  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorName) name:postName object:nil];


#pragma mark - UIAppearance
#pragma mark - Navigation Bar

#define HideNavigationBar(hide) self.navigationController.navigationBarHidden = (hide);
#define HideNavigationBarAndStatusBar self.navigationController.navigationBarHidden = YES;[[UIApplication sharedApplication] setStatusBarHidden:YES]

#define HideNavigationBarAndStatusBarWithParam(navHide, statusHide) self.navigationController.navigationBarHidden = (navHide);[[UIApplication sharedApplication] setStatusBarHidden:(statusHide)]
#define STATUS_BAR_STYLE_DEFAULT  UIStatusBarStyleDefault
#define STATUS_BAR_STYLE_LIGHTCONTENT UIStatusBarStyleLightContent


#pragma mark - UI related
#pragma mark - Custom color

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#pragma mark - Font

#define CustomFontWithSize(n,s) [UIFont fontWithName:(n) size:(s)]

#define FontNumberDinBoldWithSize(s) CustomFontWithSize(@"DIN Alternate", s)


#pragma mark - Size

#define isPortrait (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))

#define SCREEN_WIDTH (isIOS8 ? [[UIScreen mainScreen] bounds].size.width : (isPortrait ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height))

#define SCREEN_HEIGHT (isIOS8 ? [[UIScreen mainScreen] bounds].size.height : (isPortrait ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))

#define STATUSBAR_HEIGHT (isPortrait ? [[UIApplication sharedApplication] statusBarFrame].size.height : [[UIApplication sharedApplication] statusBarFrame].size.width)

#define NAVIGATION_HEIGHT  CGRectGetHeight(self.navigationController.navigationBar.frame)

#define TABBAR_HEIGHT     CGRectGetHeight(self.tabBarController.tabBar.frame)

#define SCREEN_RECT CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)


#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

#define LogRect(rect, desc) NSLog(@"%@---%@", NSStringFromCGRect(rect), desc)
#define LogSize(size, desc) NSLog(@"%@---%@", NSStringFromCGSize(size), desc)
#define LogPoint(point, desc) NSLog(@"%@---%@", NSStringFromCGPoint(point), desc)

#pragma mark - System Version

#define IPHONE4_HEIGHT 480.0f
#define IPHONE5_HEIGHT 568.0f
#define IPHONE6_HEIGHT 667.0f
#define IPHONE6P_HEIGHT 736.0f
#define IPHONE6P_WIDTH 414.0f
#define IPHONE6_WIDTH 375.0f
#define IPHONE5_WIDTH 320.0f
#define isIOS7 (fabs([[[UIDevice currentDevice] systemVersion] floatValue]) >= fabs(7.0f))
#define isIOS8 (fabs([[[UIDevice currentDevice] systemVersion] floatValue]) >= fabs(8.0f))

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define f(value) (floor(value * 100) / 100)
#define d(value) (NSInteger)(value / 100) * 100

#define BUGTAGS_KEY @"28506227a493a74e8a1da3803fb5ebff"

#define QR_PARTNER_ID @"201708091001932509"
#define QR_MD5_KEY @"hdjjas_fj123asak699_rpoyijbdsdf"
#define QR_NOTIFY_URL @"http://www.qulicai8.com:8996/p2p-notify/service"

//#define QR_PARTNER_ID @"201408071000001543"
//#define QR_MD5_KEY @"201408071000001543test_20140812"
//#define QR_NOTIFY_URL @"https://tnotify.qulicai8.com/p2p-notify/service"

#define QR_APPSTORE_URL @"https://itunes.apple.com/us/app/%E8%B6%A3%E7%90%86%E8%B4%A2-%E8%B6%A3%E8%9E%8D%E9%87%91%E6%9C%8D%E6%97%97%E4%B8%8B%E4%BF%A1%E7%94%A8%E8%B4%B7%E6%AC%BE%E4%BF%A1%E6%81%AF%E4%B8%AD%E4%BB%8B%E5%B9%B3%E5%8F%B0/id1282823112?l=zh&ls=1&mt=8"

#define QR_SHARE_URL @"http://h5.qulicai8.com:3478/qlc_jumpShareRegister.html?uid="

#define QR_SHARE_TITLE @"趣理财，13%稳健高收益"
#define QR_SHATE_DESC  @"签约上海银行存管，安全稳健，放心投资。新人专享2888元理财金~"


#define QR_UMENT_FORMAL @"59edc065734be429ae000011"
#define QR_UMENT_TEST @"59edc10a677baa476d000012"

#define QQ_APPID         @"1106341969"

#define WECHAT_APP_ID    @"wxc72a319f630a4c5b"


//测试网关
#define QR_PAY_URL @"http://192.168.3.7:8024/"

//正式网关
//#define QR_PAY_URL @"https://tpayment.qulicai8.com/"

#define QR_ACCESS_KEY  @"LTAIWraNnTMqVlh4"
#define QR_SECRET_KEY  @"GBtNC4TAr7uxbCn5HtI9p5U6nfnVNZ"

#define QR_OSS_BUCKET @"qlc"
#define QR_OSS_ENDPOSINT @"http://oss-cn-shanghai.aliyuncs.com"

#define QR_SING_TYPE @"MD5"

#define QR_LOOK_MONEY @"LOOKMONEY"

#define QR_CURRENT_TOKEN @"token"

#define QR_PRICE_STAUTS  @"price"

#define QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS @"QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS"

#define QR_IDENTITY_ERROR @"令牌错误"

#define QR_PRODUCT_PERIOD @"period"

#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"

#endif
