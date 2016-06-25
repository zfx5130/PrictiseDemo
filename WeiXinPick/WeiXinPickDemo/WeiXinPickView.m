
//
//  WeiXinPickView.m
//  WeiXinPickDemo
//
//  Created by chaos on 7/21/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "WeiXinPickView.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define maxPicNumber 99
#define maxScale 1.3
#define minScale 0.4
#define collectionCellHeight 188
#define collectionCellSpace 10
#define maxSelectNumber 9
#define margin 10

static NSString *collectionReusableViewIdentifier = @"selectView";

@interface WeiXinPickCellFlowLayout : UICollectionViewFlowLayout

@end


NSString * const WeiXinPickFlowLayoutKind = @"select";

#define kHorizontalInset 4.0
#define kVericaInset 10.0

@implementation WeiXinPickCellFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
{
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for (UICollectionViewLayoutAttributes *attrs in [attributes copy]) {
        [attributes addObject:[self layoutAttributesForSupplementaryViewOfKind:WeiXinPickFlowLayoutKind atIndexPath:attrs.indexPath]];
    }
    
    return attributes;
}

// 为追加试图布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CGRect collectionViewBounds = self.collectionView.bounds;
    CGFloat collectionViewXOffset = self.collectionView.contentOffset.x;
    
    UICollectionViewLayoutAttributes *cellAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *checkAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    checkAttributes.size = CGSizeMake(27, 27);
    
    CGFloat checkVerticalCenter = checkAttributes.size.height/2 + kVericaInset;
    
    checkAttributes.center = (CGPoint){
        CGRectGetMaxX(cellAttributes.frame) - kHorizontalInset - checkAttributes.size.width/2,
        checkVerticalCenter
    };
    
    CGFloat leftSideOfCell = CGRectGetMinX(cellAttributes.frame);
    CGFloat rightSideOfVisibleArea = collectionViewXOffset + CGRectGetWidth(collectionViewBounds);
    if (leftSideOfCell < rightSideOfVisibleArea && CGRectGetMaxX(checkAttributes.frame) >= rightSideOfVisibleArea) {
        checkAttributes.center = (CGPoint){
            rightSideOfVisibleArea - checkAttributes.size.width/2,
            checkVerticalCenter
        };
    }
    
    if (CGRectGetMinX(checkAttributes.frame) < leftSideOfCell + kHorizontalInset) {
        checkAttributes.center = (CGPoint) {
            leftSideOfCell + kHorizontalInset + checkAttributes.size.width/2,
            checkVerticalCenter
        };
    }
    return checkAttributes;
}

@end


@interface WeiXinPickCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *thumbnail;



@end

@implementation WeiXinPickCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _thumbnail = [UIImageView.alloc initWithFrame:self.bounds];
        _thumbnail.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail.clipsToBounds = YES;
        [self.contentView addSubview:_thumbnail];
        
    }
    return self;
}

@end

@interface WeiXinPickReusableView : UICollectionReusableView

@property (nonatomic, strong) UIImageView *selectionImageView;

@property (nonatomic, getter=isCellSelected) BOOL cellSelected;

@end


@implementation WeiXinPickReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImage *image = [UIImage imageNamed:@"photo_unselect_img"];
    _selectionImageView = [[UIImageView alloc] init];
    _selectionImageView.image = image;
    _selectionImageView.contentMode = UIViewContentModeScaleAspectFit;
    _selectionImageView.frame = self.bounds;
    [self addSubview:_selectionImageView];
    
    
}

- (void)setCellSelected:(BOOL)cellSelected
{
    _cellSelected = cellSelected;
    if (cellSelected) {
        self.selectionImageView.image = [UIImage imageNamed:@"photo_select_img"];
    }else{
        self.selectionImageView.image = [UIImage imageNamed:@"photo_unselect_img"];
    }
}

@end



@interface WeiXinPickView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>


@property (nonatomic, strong) NSArray *rowData; // 按钮标题
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *imageArrays;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *assets;


@property (nonatomic, weak) UIView *bottomContentView;
@property (nonatomic, strong) NSMapTable *indexPathToCheckViewTable;

@end

@implementation WeiXinPickView


#pragma mark - 从相册获取照片
-(void)getPhotosFromALAssetsLibrary
{
    
    if (!self.assetsLibrary){
        self.assetsLibrary = [self.class defaultAssetsLibrary];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group)
            {
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                if (group.numberOfAssets > 0){
                    self.assetsGroup = group;
                    [self setupAssets];
                }
            }
        };
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self changeViewIfNotAllowed];
            });
        };
        
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                          usingBlock:resultsBlock
                                        failureBlock:failureBlock];
    });
}

- (void)setupAssets
{
    if (!self.imageArrays){
        self.imageArrays = [NSMutableArray array];
    }
    else if(self.imageArrays.count > 0){
        [self.imageArrays removeAllObjects];
    }
    if (!self.assets){
        self.assets = [NSMutableArray array];
    }
    else if(self.assets.count > 0){
        [self.assets removeAllObjects];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
            if (asset)
            {
                if (self.assets.count > maxPicNumber) {
                    *stop = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                    });
                }
                NSString *type = [asset valueForProperty:ALAssetPropertyType];
                if ([type isEqual:ALAssetTypePhoto]){
                    UIImage *image = [UIImage imageWithCGImage: [asset aspectRatioThumbnail]];
                    [self.imageArrays addObject:image];
                    
                    [self.assets addObject:asset];
                    
                    if (self.assets.count == 5) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.collectionView reloadData];
                        });
                    }
                }
                
            }
            if(index == 0){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }
        };
        [self.assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:resultsBlock];
    });
    
}

#pragma mark - ALAssetsLibrary
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

- (NSMutableArray *)selectedAssets
{
    if (_selectedAssets == nil) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    self.frame = [UIScreen mainScreen].bounds;
    // 添加手势
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    // 底部contentView
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.frame.size.width , 355);
    [self addSubview:view];
    self.bottomContentView = view;
    
    // 自定义布局
    WeiXinPickCellFlowLayout *flowLayout = [[WeiXinPickCellFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = collectionCellSpace;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, collectionCellSpace, 0, collectionCellSpace);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bottomContentView.frame.size.width, 200)
                                             collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsMultipleSelection=YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView registerClass:[WeiXinPickCollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([WeiXinPickCollectionViewCell class])];
    
    [self.collectionView registerClass:[WeiXinPickReusableView class] forSupplementaryViewOfKind:WeiXinPickFlowLayoutKind withReuseIdentifier:collectionReusableViewIdentifier];
    [self.bottomContentView addSubview:self.collectionView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) , self.bottomContentView.frame.size.width, 155) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.scrollEnabled = NO;
    [self.bottomContentView addSubview:self.tableView];
    
    // 加载数据
    [self loadData];
    // 加载相册
    [self getPhotosFromALAssetsLibrary];
    
    // 调整分割线
    if ([self.tableView respondsToSelector:@selector(layoutMargins)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    self.indexPathToCheckViewTable = [NSMapTable strongToWeakObjectsMapTable];
}

- (void)loadData
{
    self.rowData = @[@[@"拍摄",@"从相册选择"],@[@"取消"]];
}

#pragma mark -- UICollectionViewDelegate and UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeiXinPickCollectionViewCell *cell =nil;
    NSString *cellIdentifier = NSStringFromClass([WeiXinPickCollectionViewCell class]);
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.thumbnail.image = self.imageArrays[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath;
{
    WeiXinPickReusableView *pictureSelectView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionReusableViewIdentifier forIndexPath:indexPath];
    pictureSelectView.cellSelected = [self.selectedAssets containsObject:self.assets[indexPath.row]];
    [self.indexPathToCheckViewTable setObject:pictureSelectView forKey:indexPath];
    return pictureSelectView;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeiXinPickReusableView *pictureSelectView = [self.indexPathToCheckViewTable objectForKey:indexPath];
    [collectionView bringSubviewToFront:pictureSelectView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = self.imageArrays[indexPath.row];
    CGFloat scale = image.size.width/ image.size.height;
    if (scale < minScale) {
        scale = minScale;
    }else if(scale > maxScale){
        scale = maxScale;
    }
    CGFloat width = scale * collectionCellHeight;
    
    return CGSizeMake(width, collectionCellHeight);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self.selectedAssets removeAllObjects];
    self.selectedAssets = nil;
    [self.selectedAssets addObject:self.assets[indexPath.row]];
    WeiXinPickReusableView *pictureSelectView = [self.indexPathToCheckViewTable objectForKey:indexPath];
    pictureSelectView.cellSelected = [self.selectedAssets containsObject:self.assets[indexPath.row]];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
    NSLog(@"%@",self.imageArrays[indexPath.item]);
    [self.collectionView reloadData];
    if (self.clickBlock) {
        self.clickBlock(self.imageArrays[indexPath.item],PickPictureSendPicture);
    }
}

#pragma mark -- UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rowData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.rowData[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PickPictureTableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = self.rowData[indexPath.section][indexPath.row];
    if([cell.textLabel.text rangeOfString:@"发送"].length !=0 ){
        cell.textLabel.textColor = [UIColor greenColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissBlock:^(BOOL Complete) {
        
    }];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.clickBlock) {
                self.clickBlock(nil,PickPictureTakePhoto);
            }
        }else if (indexPath.row == 1){
            if (self.clickBlock) {
                self.clickBlock(nil,PickPictureChoosePicture);
            }
        }
    }else if(indexPath.section == 1){
        if (self.clickBlock) {
            self.clickBlock(nil,PickPictureCancel);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


#pragma mark -- private method
- (NSArray*)sortObjectsWithFrame:(NSArray*)objects
{
    NSComparator comparatorBlock = ^(id obj1, id obj2) {
        if ([obj1 frame].origin.x > [obj2 frame].origin.x) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 frame].origin.x < [obj2 frame].origin.x) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSMutableArray *fieldsSort = [NSMutableArray.alloc initWithArray:objects];
    [fieldsSort sortUsingComparator:comparatorBlock];
    
    return [NSArray arrayWithArray:fieldsSort];
}

// 点击空白处消失
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    if( CGRectContainsPoint(self.frame, [tap locationInView:self.bottomContentView])) {
        
    } else{
        [self dismissBlock:^(BOOL Complete) {
            
        }];
    }
}

- (void)dismissBlock:(CompleteAnimationBlock)block
{
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect frame = self.bottomContentView.frame;
        frame.origin.y = self.frame.size.height;
        self.bottomContentView.frame = frame;
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
    } completion:^(BOOL finished) {
        block(finished);
        [self removeFromSuperview];
    }];
}

- (void)presentBlock:(CompleteAnimationBlock)block
{
    CGRect frame = self.bottomContentView.frame;
    frame.origin.y = self.frame.size.height;
    self.bottomContentView.frame = frame;
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect frame = self.bottomContentView.frame;
        frame.origin.y = self.frame.size.height - self.bottomContentView.frame.size.height;
        self.bottomContentView.frame = frame;
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    } completion:^(BOOL finished) {
        block(finished);
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self) {
        return NO;
    }
    return YES;
}

/**
 *  用户禁止
 */
- (void)changeViewIfNotAllowed
{
    CGRect frame = self.bottomContentView.frame;
    frame.origin.y += self.collectionView.frame.size.height;
    self.frame = frame;
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y -= self.collectionView.frame.size.height;
    self.frame = frame;
    [self.collectionView removeFromSuperview];
}

@end

