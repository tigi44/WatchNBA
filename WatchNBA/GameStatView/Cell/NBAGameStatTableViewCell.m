//
//  NBAGameStatTableViewCell.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameStatTableViewCell.h"
#import "NBAGameStatCollectionViewModel.h"

@interface NBAGameStatTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, readwrite) UICollectionView *collectionView;

@end

@implementation NBAGameStatTableViewCell {
    NSArray<id<NBAGameStatCollectionViewModelProtocol>> *_leaders;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier {
    self = [super initWithStyle:aStyle reuseIdentifier:aReuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        [self setupSubview];
        
        _leaders = [NSArray array];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)setupSubview {
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    
    UICollectionViewFlowLayout *sLayout = (UICollectionViewFlowLayout *)[_collectionView collectionViewLayout];
    [sLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [sLayout setFooterReferenceSize:CGSizeZero];
    [sLayout setHeaderReferenceSize:CGSizeZero];
    [sLayout setMinimumLineSpacing:0.0f];
    [sLayout setMinimumInteritemSpacing:0.0f];
    
    [_collectionView setBackgroundColor:[UIColor darkGrayColor]];
    [_collectionView setPagingEnabled:YES];
    [_collectionView registerClass:[NBAGameStatCollectionViewModel collectionViewCellClass] forCellWithReuseIdentifier:NSStringFromClass([NBAGameStatCollectionViewModel collectionViewCellClass])];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[self class] tableViewCellHeight])];

    [self addSubview:_collectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    //[self setupSubview];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_leaders count];
}

-(NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
    id<NBAGameStatCollectionViewModelProtocol> sViewModel = _leaders[aSection];
    if ([sViewModel conformsToProtocol:@protocol(NBAGameStatCollectionViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        return [sViewModel collectionView:aCollectionView numberOfItemsInSection:aSection];
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    id<NBAGameStatCollectionViewModelProtocol> sViewModel = _leaders[[aIndexPath section]];
    if ([sViewModel conformsToProtocol:@protocol(NBAGameStatCollectionViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        return [sViewModel collectionView:aCollectionView cellForItemAtIndexPath:aIndexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    id<NBAGameStatCollectionViewModelProtocol> sViewModel = _leaders[[aIndexPath section]];
    if ([sViewModel conformsToProtocol:@protocol(NBAGameStatCollectionViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [sViewModel collectionView:aCollectionView layout:aCollectionViewLayout sizeForItemAtIndexPath:aIndexPath];
    }
    return CGSizeZero;
}

#pragma mark -

- (void)setupCollectionViewWithvTeamLeadersData:(NBAVOStatLeader *)aVTeamLeaders hTeamLeaders:(NBAVOStatLeader *)aHTeamLeaders {
    if (aVTeamLeaders && aHTeamLeaders) {
        _leaders = @[[[NBAGameStatCollectionViewModel alloc] initWithTeamLeadersData:aVTeamLeaders imageSideOption:ImageSideLeft],
                     [[NBAGameStatCollectionViewModel alloc] initWithLabelData],
                     [[NBAGameStatCollectionViewModel alloc] initWithTeamLeadersData:aHTeamLeaders imageSideOption:ImageSideRight]];
        [_collectionView reloadData];
    }
}

#pragma mark -

+ (float)tableViewCellHeight {
    return [[UIScreen mainScreen] bounds].size.height * 1.8 / 3;
}

@end
