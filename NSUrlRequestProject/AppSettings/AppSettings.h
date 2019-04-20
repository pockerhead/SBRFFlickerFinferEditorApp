//
//  AppSettings.h
//  NSUrlRequestProject
//
//  Created by pockerhead on 19/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define searchURL @"flickerFinderApp://search?query="

@interface AppSettings : NSObject

+ (NSString *)lastSearchQuery;
+ (void)setLastSearchQuery:(NSString *)lastSearchQuery;

@end

NS_ASSUME_NONNULL_END
