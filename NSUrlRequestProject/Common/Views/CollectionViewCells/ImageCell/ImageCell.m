//
//  ImageCell.m
//  NSUrlRequestProject
//
//  Created by pockerhead on 18/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//

#import "ImageCell.h"


@interface ImageCell ()

@property (strong, nonatomic) NetworkService *imageLoader;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageView];
        [self addSubview:_activityIndicator];
        self.backgroundColor = UIColor.lightGrayColor;
        self.layer.cornerRadius = 13;
        self.layer.masksToBounds = YES;
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _imageView.layer.masksToBounds = YES;
        _imageLoader = [NetworkService new];
    }
    return self;
}

- (void)layoutSubviews
{
    self.imageView.frame = self.bounds;
    self.activityIndicator.frame = self.bounds;
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
    [self.activityIndicator stopAnimating];
}

- (void)configureWithImageURL:(NSString *)imageURL andCompletion:(void (^)(UIImage *))completion
{
    __weak typeof(self) weakSelf = self;
    [self.activityIndicator startAnimating];
    [self.imageLoader downloadImageWithURL:imageURL progressBlock:nil completionBlock:^(UIImage *image) {
        weakSelf.imageView.image = image;
        [weakSelf.activityIndicator stopAnimating];
        if (completion)
        {
            completion(image);
        }
    }];
}

- (void)configureWithImage:(UIImage *)image
{
    [self.activityIndicator stopAnimating];
    self.imageView.image = image;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

@end
