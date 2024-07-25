//
//  MYAppDelegate.m
//  MYIOSAdsDdcxSDK
//
//  Created by zhulonghaigit on 07/24/2024.
//  Copyright (c) 2024 zhulonghaigit. All rights reserved.
//

#import "MYAppDelegate.h"
#import <MYAdsFramework/MYAdsFramework.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

@interface MYAppDelegate ()<MYSplashAdDelegate>

@property (nonatomic, strong) MYSplashAd *splash;
@property (nonatomic, strong) UIImageView *splashImage;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation MYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    Class view = NSClassFromString(@"MYViewController");
    UIViewController *vc = [[view alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [[MYAdsConfiguration shareInstance] initConfigurationWithAppId:@"1061"];
    _splash = [[MYSplashAd alloc] initWithSpaceId:@"6865"];
    _splash.delegate = self;
    _splash.zoomController = self.window.rootViewController;
    _splash.customBottomView = self.bottomView;
    [self.window addSubview:self.splashImage];
    [_splash MY_loadAd];
    return YES;
}


#pragma mark - delegate
- (void)MY_splashAdDidLoad {
    [_splash MY_showInWindow:self.window withBottomView:self.bottomView];
}
- (void)MY_splashAdFailToPresent:(NSError *)error{
    NSLog(@"开屏无填充=====%@",error);
    [self.splashImage removeFromSuperview];
}
- (void)MY_splashAdSuccessPresentScreen{
   NSLog(@"开屏广告加载成功");
}
- (void)MY_splashAdWillClose{
    NSLog(@"开屏广告即将关闭");
}
- (void)MY_splashAdClosed{
    NSLog(@"开屏广告关闭");
    [self.splashImage removeFromSuperview];
}
- (void)MY_splashAdClicked{
    NSLog(@"开屏广告点击");
}
- (void)MY_splashAdExposured{
    NSLog(@"开屏广告曝光");
}
- (void)MY_splashAdLifeTime:(NSUInteger)time{
    NSLog(@"开屏广告剩余时间：%lu",(unsigned long)time);
}

#pragma mark - lazy
- (UIImageView *)splashImage{
    if (!_splashImage) {
        _splashImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _splashImage.backgroundColor = UIColor.whiteColor;
    }
    return _splashImage;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        CGRect rect = CGRectMake(0, 0, self.window.bounds.size.width, 100);
        _bottomView = [[UIView alloc] initWithFrame:rect];
    }
    return _bottomView;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                [[MYAdsConfiguration shareInstance] setSDKIDFA:idfa];
            } else {
                //NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
                [[MYAdsConfiguration shareInstance] setSDKIDFA:@""];
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
