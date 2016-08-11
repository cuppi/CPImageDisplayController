//
//  ViewController.m
//  CPImageDisplayControllerDemo
//
//  Created by cuppi on 2016/8/10.
//  Copyright © 2016年 cuppi. All rights reserved.
//

#import "ViewController.h"
#import "CPImageDisplayController.h"

@interface ViewController () <CPImageDisplayControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionPresent:(id)sender {
    
    CPImageDisplayController *displayController = [[CPImageDisplayController alloc] init];
    displayController.delegate = self;
    NSArray *urlString = @[@"http://Img.wangpiao.com/CmsImage/1/2/2016/26355/4147e1d6-bcd4-43d6-96b8-6baafe4697a0.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/d458c4e7-a7be-4c59-bfdc-99a4ed62f98c.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/f0b281ea-ced8-4705-8fa7-ff9f663a332f.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/3cf61be2-7232-4349-98e8-7b430470533d.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/bae5f9eb-7f8e-4869-ba15-240b74df15e8.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/2fd76aef-9903-4e6f-839d-fc84989535fd.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/3d30aec2-de7d-4b14-b860-c54b25aa9340.jpg",
                            @"http://Img.wangpiao.com/CmsImage/1/2/2016/26348/349eea10-60db-4431-890a-3e6bf3467b45.jpg" ];
    NSMutableArray *urls = [NSMutableArray array];
    for (NSString *string in urlString) {
        [urls addObject:[NSURL URLWithString:string]];
    }
    displayController.imageUrls = urls;
    [self presentViewController:displayController animated:YES completion:nil];
    
}

@end
