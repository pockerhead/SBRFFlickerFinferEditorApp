//
//  Photo.m
//  NSUrlRequestProject
//
//  Created by pockerhead on 06/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithServerResponce:(NSDictionary *)response
{
    self = [super init];
    if (self)
    {
        self.serverID = response[@"server"];
        self.farm = response[@"farm"];
        self.secret = response[@"secret"];
        self.photoID = response[@"id"];
    }
    
    return self;
}

@end
