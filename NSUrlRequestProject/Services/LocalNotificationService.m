//
//  LocalNotificationService.m
//  NSUrlRequestProject
//
//  Created by pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import "LocalNotificationService.h"
#import "PhotoFinderAssembly.h"
#import "MainNavigationTabBarController.h"
@import UIKit;
@import UserNotifications;



@interface LocalNotificationService () <UNUserNotificationCenterDelegate>

@end

@implementation LocalNotificationService

static NSString *const firstCategory = @"firstCategory";
static NSString *const secondCategory = @"secondCategory";

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)shared
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)addLocalNotificationWithInterval:(NSTimeInterval)interval title:(NSString *)title subtitle:(NSString *)subtitle type:(LCTTriggerType)type routeURL:(NSString *)url
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = title;
    content.subtitle = subtitle;
    content.sound = [UNNotificationSound defaultSound];
    
//    content.attachments = @[[self imageAttachment],[self imageAttachment],[self imageAttachment]];
    
    UNNotificationTrigger *trigger = [self getTriggerWithInterval:interval repeats:NO];
    content.userInfo = @{@"urlToOpen": url};
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    NSString *identifier = [NSString stringWithFormat:@"NOTIFICATION_%@", [[NSUUID UUID] UUIDString]];
    content.categoryIdentifier = firstCategory;
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    [self addCustomActions];

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (UNTimeIntervalNotificationTrigger *)getTriggerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:repeats];
}

- (UNCalendarNotificationTrigger*)triggerWithHour:(NSInteger)hour repeats:(BOOL)repeats
{
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond fromDate:[NSDate dateWithTimeIntervalSinceNow:hour * 60 * 60]];
    return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:repeats];
}

- (UNNotificationAttachment *)imageAttachment
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"sberCat" withExtension:@"png"];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"pushImage" URL:fileURL options:nil error:nil];
    
    return attachment;
}

- (void)addCustomActions
{
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"Test" title:@"Test" options:UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"OtherTest" title:@"OtherTest" options:UNNotificationActionOptionDestructive];
    UNNotificationCategory *cat = [UNNotificationCategory categoryWithIdentifier:firstCategory actions:@[action1, action2] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    NSSet *categories = [NSSet setWithObject:cat];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:categories];
}



@end
