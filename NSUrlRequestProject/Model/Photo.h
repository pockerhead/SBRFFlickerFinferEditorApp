//
//  Photo.h
//  NSUrlRequestProject
//
//  Created by pockerhead on 06/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject

@property NSString *secret;
@property NSString *photoID;
@property NSString *serverID;
@property NSNumber *farm;
@property NSString *imageURL;
@property UIImage *image;

-(instancetype)initWithServerResponce:(NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
