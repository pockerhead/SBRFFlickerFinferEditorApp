//
//  PhotoFinderViewController.h
//  NSUrlRequestProject
//
//  Created pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import <UIKit/UIKit.h>
#import "PhotoFinderProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoFinderViewController : UIViewController<PhotoFinderView>

@property (nonatomic, strong) NSObject<PhotoFinderPresenterInterface>* presenter;

@end

NS_ASSUME_NONNULL_END
