//
//  CPImageDisplayController.h
//  CPImageDisplayControllerDemo
//
//  Created by cuppi on 2016/8/10.
//  Copyright © 2016年 cuppi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPImageDisplayController;
@protocol CPImageDisplayControllerDelegate <NSObject>
@required
@optional
@end

@interface CPImageDisplayController : UIViewController

@property (assign, nonatomic) id<CPImageDisplayControllerDelegate> delegate;
@property (retain, nonatomic) NSArray <NSURL *>*imageUrls;
@end
