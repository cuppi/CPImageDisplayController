//
//  UIView+CPGrid.m
//  CPImageDisplayControllerDemo
//
//  Created by cuppi on 2016/8/10.
//  Copyright © 2016年 cuppi. All rights reserved.
//

#import "UIView+CPGrid.h"

@implementation UIView (CPGrid)
- (CGFloat)cp_left
{
    return self.frame.origin.x;
}

- (CGFloat)cp_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)cp_top
{
  return self.frame.origin.y;
}

- (CGFloat)cp_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)cp_width
{
    return self.frame.size.width;
}

- (CGFloat)cp_height
{
    return self.frame.size.height;
}

@end
