//
//  MainNavigationTabBarController.h
//  NSUrlRequestProject
//
//  Created by pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationProtocols.h"
#import "PhotoEditorViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainNavigationTabBarController : UITabBarController <MainNavigationView>

@property (weak, nonatomic) id<MainNavigationPresenterInterface> presenter;
@property (weak, nonatomic) PhotoEditorViewController *photoEditor;

- (void)configureInitialControllersWithSearchQuery:(NSString *)search selectedIndex:(NSInteger)selectedIndex;


@end

NS_ASSUME_NONNULL_END
