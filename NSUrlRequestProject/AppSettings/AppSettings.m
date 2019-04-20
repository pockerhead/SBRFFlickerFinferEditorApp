//
//  AppSettings.m
//  NSUrlRequestProject
//
//  Created by pockerhead on 19/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+ (NSString *)lastSearchQuery
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"lastSearchQuery"];
}

+ (void)setLastSearchQuery:(NSString *)lastSearchQuery
{
    [[NSUserDefaults standardUserDefaults] setValue:lastSearchQuery forKey:@"lastSearchQuery"];
}

@end
