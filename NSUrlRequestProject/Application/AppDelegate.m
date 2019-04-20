//
//  AppDelegate.m
//  NSUrlRequestProject
//
//  Created by Alexey Levanov on 30.11.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "AppDelegate.h"
#import "MainNavigationAssembly.h"
#import "AppSettings.h"
#import "MainNavigationTabBarController.h"

@import UserNotifications;


@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [UIWindow new];
    self.window.rootViewController = [MainNavigationAssembly createModule];
    [self.window makeKeyAndVisible];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options =  (UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
    center.delegate = self;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
        }
    }];
    [LocalNotificationService shared];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    [center removeAllPendingNotificationRequests];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[LocalNotificationService new] addLocalNotificationWithInterval:15 title:@"Привет!" subtitle:[NSString stringWithFormat:@"Кажется ты долго не искал %@", [AppSettings lastSearchQuery]] type:LCTTriggerTypeInterval routeURL:[NSString stringWithFormat:@"%@%@",searchURL, [AppSettings lastSearchQuery]]];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    [center removeAllPendingNotificationRequests];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    completionHandler((UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert));
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    NSString *urlString = content.userInfo[@"urlToOpen"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [url.query componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        
        [queryStringDictionary setObject:value forKey:key];
    }
    
    if (url)
    {
        if ([url.scheme containsString:@"http"])
        {
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }
        else if ([url.scheme containsString:@"flickerFinderApp"])
        {
            if ([url.path containsString:@"search"] || [url.host containsString:@"search"])
            {
                NSString *query = [queryStringDictionary objectForKey:@"query"];
                if (query)
                {
                    MainNavigationTabBarController *rootTabbar = (MainNavigationTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                    [rootTabbar configureInitialControllersWithSearchQuery:query selectedIndex:0];
                }
            }
        }
        
    }
    
    if (completionHandler)
    {
        completionHandler();
    }
}

@end
