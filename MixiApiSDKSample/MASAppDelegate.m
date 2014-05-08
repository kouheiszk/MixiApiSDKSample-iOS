//
//  MASAppDelegate.m
//  MixiApiSDKSample
//
//  Created by 七尾 貴史 on 2014/02/21.
//  Copyright (c) 2014年 七尾 貴史. All rights reserved.
//

#import "MASAppDelegate.h"
#import "MixiSDK.h"

@implementation MASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Mixi *mixi = [[Mixi sharedMixi] setupWithType:kMixiApiTypeSelectorGraphApi
                                         clientId:@"e001c6f009d9486d56fe"
                                           secret:@"886b71e773a212c42ec15725ea19761913409ca0"];
    mixi.authorizer = [MixiAppAuthorizer authorizer];

    [mixi restore];
    [mixi reportOncePerDay];

    if ([mixi isMixiAppInstalled]) {
        NSLog(@"mixi offcial client app is installed.");
    }

    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSError *error = nil;
    NSString *apiType = [[Mixi sharedMixi] application:application
                                               openURL:url
                                     sourceApplication:sourceApplication
                                            annotation:annotation
                                                 error:&error];

    if (error) {
        // エラーが発生しました
        NSLog(@"エラーが発生しました");
    }
    else if ([apiType isEqualToString:kMixiAppApiTypeToken]) {
        // 認可処理に成功しました
        NSLog(@"認可処理に成功しました");
    }
    else if ([apiType isEqualToString:kMixiAppApiTypeRevoke]) {
        // 認可解除処理に成功しました
        NSLog(@"認可解除処理に成功しました");
    }
    else if ([apiType isEqualToString:kMixiAppApiTypeReceiveRequest]) {
        // リクエストAPIによるリクエスト受け取り
        NSLog(@"リクエストAPIによるリクエスト受け取り");
    }

    return YES;
}

@end
