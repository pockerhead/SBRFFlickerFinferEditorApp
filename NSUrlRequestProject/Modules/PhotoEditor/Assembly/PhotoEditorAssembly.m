//
//  PhotoEditorAssembly.m
//  NSUrlRequestProject
//
//  Created pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PhotoEditorAssembly.h"
#import "PhotoEditorViewController.h"
#import "PhotoEditorPresenter.h"
#import "PhotoEditorProtocols.h"
#import "PhotoEditorRouter.h"

@interface PhotoEditorAssembly ()

@end

@implementation PhotoEditorAssembly

+ (UIViewController *)createModuleWithImage:(UIImage *)image {
    PhotoEditorViewController *view = [[PhotoEditorViewController alloc] initWithImage:image];
    PhotoEditorRouter *router = [[PhotoEditorRouter alloc] init];
    PhotoEditorPresenter *presenter = [[PhotoEditorPresenter alloc] initWithView:view router:router];
    view.presenter = presenter;
    router.viewController = view;
    return view;
}

@end
