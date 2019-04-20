//
//  ImageCell.h
//  NSUrlRequestProject
//
//  Created by pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageCell : UICollectionViewCell

- (void)configureWithImageURL:(NSString *)imageURL andCompletion:(void (^)(UIImage *))completion;
- (void)configureWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
