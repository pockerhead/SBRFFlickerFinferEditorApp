//
//  PhotoFinderPresenter.m
//  NSUrlRequestProject
//
//  Created pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//
//  Template generated by Balashov Artem @pockerhead
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PhotoFinderPresenter.h"
#import "PhotoFinderProtocols.h"
#import "NetworkService.h"
#import "AppSettings.h"

@interface PhotoFinderPresenter () <PhotoFinderPresenterInterface>
@property (strong, nonatomic) NSObject<PhotoFinderWireframeInterface>* router;
@property (strong, nonatomic) id<NetworkServiceIntputProtocol> networkService;
@property (strong, nonatomic) NSString *searchQuery;
@property (strong, nonatomic) NSArray <Photo *> *dataSource;

@end

@implementation PhotoFinderPresenter

- (instancetype)initWithView:(NSObject<PhotoFinderView>*)view
                      router:(NSObject<PhotoFinderWireframeInterface>*)router
                 searchQuery:(NSString *)query {
    self = [super init];
    if (self) {
        _view = view;
        _router = router;
        _networkService = [NetworkService new];
        _searchQuery = query;
    }
    return self;
}

- (void)viewDidAppear {
    //Default implementation
}

- (void)viewDidDissappear {
    //Default implementation
}

- (void)viewDidLoad {
    if (self.searchQuery && [self.searchQuery isEqualToString:@""] == NO)
    {
        [self.view displaySeachQuery:self.searchQuery];
    }
}

- (void)viewWillAppear {
    //Default implementation
}

- (void)viewWillDissappear {
    //Default implementation
}

- (void)didEnterSearchFieldWithQuery:(nonnull NSString *)query {
    __weak typeof(self) weakSelf = self;
    [self.networkService findFlickrPhotoWithSearchString:query completionBlock:^(NSArray<Photo *> *photos) {
        [AppSettings setLastSearchQuery:query];
        [weakSelf.view displayPhotos:photos];
        self.dataSource = photos;
    }];
}


- (void)didSelectImageCellAtIP:(nonnull NSIndexPath *)ip {
    NSInteger index = ip.row;
    if (index < self.dataSource.count)
    {
        UIImage *targetPhoto = self.dataSource[index].image;
        if (targetPhoto)
        {
            [self.router navigateToPhotoEditorWithImage:targetPhoto];
        }
    }
}


@end
