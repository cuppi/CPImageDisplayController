//
//  CPImageDisplayController.m
//  CPImageDisplayControllerDemo
//
//  Created by cuppi on 2016/8/10.
//  Copyright © 2016年 cuppi. All rights reserved.
//

#import "CPImageDisplayController.h"
#import "CPImageDisplayCell.h"
#import "UIView+CPGrid.h"
#import "pop.h"

@interface CPImageDisplayController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    CGFloat _screenWidth;
    CGFloat _screenHeight;
}
@end

@implementation CPImageDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMetadata];
    [self configureViewController];
    [self createCollectionView];
    [self viewFillData];
}

- (void)createMetadata
{
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)configureViewController
{
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(_screenWidth, _screenHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 20;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth , _screenHeight) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CPImageDisplayCell class] forCellWithReuseIdentifier:ReuseCPImageDisplayCell];
}

- (void)setImageUrls:(NSArray<NSURL *> *)imageUrls
{
    _imageUrls = [NSArray arrayWithArray:imageUrls];
    [_collectionView reloadData];
}

- (void)setSelectedImageIndex:(NSInteger)selectedImageIndex
{
    if (selectedImageIndex < 0) {
        return;
    }
    _selectedImageIndex = selectedImageIndex;
    _collectionView.contentOffset = CGPointMake(selectedImageIndex*(_collectionView.cp_width + 20), 0);
}

- (void)viewFillData
{
    [_collectionView reloadData];
    _collectionView.contentOffset = CGPointMake(_selectedImageIndex*(_collectionView.cp_width + 20), 0);
}

#pragma mark -- CADisplay

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -- UIScrollView Delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger fullCount = offsetX/(scrollView.cp_width + 20);
    CGFloat fragment = offsetX - scrollView.cp_width*fullCount;
    // 跳转的临界速度
    CGFloat criticalSpeed = 1;
    if (ABS(velocity.x) > criticalSpeed ||
        fragment - 10 >= scrollView.cp_width*0.5) {
        fullCount += velocity.x >= 0?1:0;
    }
    
    NSInteger minIndex = 0;
    NSInteger maxIndex = MAX(0, (scrollView.contentSize.width + 20)/(_screenWidth + 20) - 1);
    fullCount = MAX(minIndex, fullCount);
    fullCount = MIN(maxIndex, fullCount);
    
    *targetContentOffset = CGPointMake(offsetX, 0);
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPCollectionViewContentOffset];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(fullCount*(scrollView.cp_width + 20), 0)];
    animation.duration = 0.3;
    [_collectionView pop_addAnimation:animation forKey:@"CollectionContentOffset"];
}

#pragma mark -- UICollection Delegate Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CPImageDisplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseCPImageDisplayCell forIndexPath:indexPath];
    cell.imageUrl = _imageUrls[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSingleTapBlock:^{
        if (_singleTapBlock) {
            _singleTapBlock(indexPath.row, _imageUrls[indexPath.row]);
        }
    }];
    return cell;
}

@end
