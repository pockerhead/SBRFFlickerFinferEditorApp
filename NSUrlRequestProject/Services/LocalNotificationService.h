//
//  LocalNotificationService.h
//  NSUrlRequestProject
//
//  Created by pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LCTTriggerTypeInterval = 0,
    LCTTriggerTypeDate = 1,
    LCTTriggerTypeLocation = 2,
} LCTTriggerType;

@interface LocalNotificationService : NSObject

- (void)addLocalNotificationWithInterval:(NSTimeInterval)interval title:(NSString *)title subtitle:(NSString *)subtitle type:(LCTTriggerType)type routeURL:(NSString *)url;
+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
