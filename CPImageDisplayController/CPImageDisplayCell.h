//
//  CPImageDisplayCell.h
//  CPImageDisplayControllerDemo
//
//  Created by cuppi on 2016/8/10.
//  Copyright © 2016年 cuppi. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *const ReuseCPImageDisplayCell = @"ReuseCPImageDisplayCell";

@interface CPImageDisplayCell : UICollectionViewCell

@property (copy, nonatomic) void(^singleTapBlock)();
@property (copy, nonatomic) void(^doubleTapBlock)();

@property (copy, nonatomic) void(^loadImageFailBlock)(NSURL *imageUrl);
@property (copy, nonatomic) NSURL *imageUrl;
@end
