//
//  MainNavigationTabBarController.m
//  NSUrlRequestProject
//
//  Created by pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import "MainNavigationTabBarController.h"
#import "PhotoFinderAssembly.h"
#import "PhotoEditorAssembly.h"
#import "LocalNotificationService.h"

@import UserNotifications;

@interface MainNavigationTabBarController () 

@end

@implementation MainNavigationTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureInitialControllersWithSearchQuery:@"Nature" selectedIndex:0];
    // Do any additional setup after loading the view.
}

//- (void)setSelectedIndex:(NSUInteger)selectedIndex
//{
//    NSInteger ind = self.selectedIndex;
//    if (self.selectedIndex > self.viewControllers.count)
//    {
//        ind = 0;
//    }
//    [UIView transitionFromView:self.viewControllers[ind].view toView:self.viewControllers[selectedIndex].view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
//    [super setSelectedIndex:selectedIndex];
//}

- (void)configureInitialControllersWithSearchQuery:(NSString *)search selectedIndex:(NSInteger)selectedIndex
{
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[PhotoFinderAssembly createModuleWithSearchQuery:search]];
    nav1.tabBarItem.title = @"Поиск фото";
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    nav2.tabBarItem.title = @"Сделать фото";
    PhotoEditorViewController *photoEditor = (PhotoEditorViewController *)[PhotoEditorAssembly createModuleWithImage:[UIImage new]];
    self.photoEditor = photoEditor;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:photoEditor];
    nav3.tabBarItem.title = @"Редактирование фото";
    [self setViewControllers:@[nav1, nav3] animated:YES];
    [self setSelectedIndex:selectedIndex];
}

@end
