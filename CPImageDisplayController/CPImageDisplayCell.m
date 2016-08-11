//
//  CPImageDisplayCell.m
//  CPImageDisplayControllerDemo
//
//  Created by cuppi on 2016/8/10.
//  Copyright © 2016年 cuppi. All rights reserved.
//

#import "CPImageDisplayCell.h"
#import "UIView+CPGrid.h"
#import "UIImageView+WebCache.h"

@interface CPImageDisplayCell () <UIScrollViewDelegate>
{
    UIScrollView *_displayScrollView;
    UIImageView *_displayImageView;
}
@end

@implementation CPImageDisplayCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell
{
    [self createScrollView];
    [self createImageView];
    [self createGesture];
}

- (void)createScrollView
{
    _displayScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.cp_width, self.cp_height)];
    [self addSubview:_displayScrollView];
    _displayScrollView.delegate = self;
    _displayScrollView.backgroundColor = [UIColor clearColor];
    _displayScrollView.minimumZoomScale = 1;
    _displayScrollView.maximumZoomScale = 2;
}

- (void)createImageView
{
    _displayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _displayScrollView.cp_width, _displayScrollView.cp_height)];
    [_displayScrollView addSubview:_displayImageView];
}

- (void)createGesture
{
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionSingleTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [_displayScrollView addGestureRecognizer:singleTapGesture];
    [_displayScrollView addGestureRecognizer:doubleTapGesture];
}

- (void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = [imageUrl copy];
    [_displayImageView sd_setImageWithURL:_imageUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            [self updateImageViewWithSize:image.size];
        }
        else
        {
            if (_loadImageFailBlock) {
                _loadImageFailBlock(imageURL);
            }
        }
    }];
}

#pragma mark -- Update ImageView
- (void)updateImageViewWithSize:(CGSize)size
{
    CGFloat zoomScale = MIN(_displayScrollView.cp_width/size.width, _displayScrollView.cp_height/size.height);
    CGSize displaySize = CGSizeMake(size.width*zoomScale, size.height*zoomScale);
    _displayImageView.bounds = CGRectMake(0, 0, displaySize.width, displaySize.height);
}

#pragma mark -- Action Area
- (void)actionSingleTap:(UIGestureRecognizer *)gesture
{
    if (_singleTapBlock) {
        _singleTapBlock();
    }
}

- (void)actionDoubleTap:(UIGestureRecognizer *)gesture
{
    if (_displayScrollView.zoomScale > 1) {
        [_displayScrollView setZoomScale:1 animated:YES];
        return;
    }
    
    CGPoint tapLocation = [gesture locationInView:_displayScrollView];
    CGFloat maxZoomScale = _displayScrollView.maximumZoomScale;
    CGFloat zoomWidth = _displayScrollView.cp_width/maxZoomScale;
    CGFloat zoomHeight = _displayScrollView.cp_height/maxZoomScale;
    CGRect zoomArea = CGRectMake(tapLocation.x - zoomWidth*0.5, tapLocation.y - zoomHeight*0.5, zoomWidth, zoomHeight);
    [_displayScrollView zoomToRect:zoomArea animated:YES];
}

#pragma mark -- UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _displayImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _displayImageView.center = CGPointMake(MAX(_displayImageView.cp_width*0.5, scrollView.cp_width*0.5), MAX(_displayImageView.cp_height*0.5, scrollView.cp_height*0.5));
}

@end
