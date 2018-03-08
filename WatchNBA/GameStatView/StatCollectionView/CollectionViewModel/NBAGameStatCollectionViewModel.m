//
//  NBAGameStatCollectionViewModel.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameStatCollectionViewModel.h"
#import "NBAApiUrl.h"
#import "UIImageView+WebImage.h"
#import <AFNetworking/AFNetworking.h>
#import "NBAVOPlayerBio.h"

const static NSInteger gStatCollectionViewRowCount = 3;

@implementation NBAGameStatCollectionViewModel {
    NSArray<NBAVOStatLeaderItem *> *_leaderItems;
    NBAGameStatCollectionViewCellImageSideOption _imageSideOption;
}

- (instancetype)initWithTeamLeadersData:(NBAVOStatLeader *)aTeamLeaders imageSideOption:(NBAGameStatCollectionViewCellImageSideOption) aImageSideOption {
    self = [super init];
    if (self) {
        _leaderItems = [NSArray array];
        if (aTeamLeaders) {
            _leaderItems = [_leaderItems arrayByAddingObject:[aTeamLeaders points]];
            _leaderItems = [_leaderItems arrayByAddingObject:[aTeamLeaders rebounds]];
            _leaderItems = [_leaderItems arrayByAddingObject:[aTeamLeaders assists]];
        }
        _imageSideOption = aImageSideOption;
    }
    return self;
}

- (instancetype)initWithLabelData {
    if (self) {
        NBAVOStatLeaderItem *sPoints = [[NBAVOStatLeaderItem alloc] initWithData:@{@"value" : @"points"}];
        NBAVOStatLeaderItem *sRebounds = [[NBAVOStatLeaderItem alloc] initWithData:@{@"value" : @"rebounds"}];
        NBAVOStatLeaderItem *sAssists = [[NBAVOStatLeaderItem alloc] initWithData:@{@"value" : @"assists"}];
        _leaderItems = @[sPoints, sRebounds, sAssists];
        _imageSideOption = ImageSideNone;
    }
    return self;
}

- (instancetype)init {
    return [self initWithTeamLeadersData:nil imageSideOption:ImageSideLeft];
}

+ (Class)collectionViewCellClass {
    return [NBAGameStatCollectionViewCell class];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection {
    return [_leaderItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    NBAGameStatCollectionViewCell *sCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([[self class] collectionViewCellClass]) forIndexPath:aIndexPath];
    NSString *sValueLabelText = [_leaderItems[[aIndexPath row]] value];
    NSArray *sPlayers = [_leaderItems[[aIndexPath row]] players];
    
    [[sCell valueLabel] setText:sValueLabelText];
    [sCell setImageSideOption:_imageSideOption];
    if ([sPlayers count] != 0) {
        NBAVOPlayer *sPlayer = [sPlayers objectAtIndex:0];
        NSString *sPlayerId = [sPlayer personId];
        NSString *sPlayerName;
        if ([sPlayers count] > 1) {
            sPlayerId = nil;
            sPlayerName = @"MultiPlayer";
        }
        NSString *sPlayerImageURLString = NBA_PLAYER_IMG_URL(sPlayerId);
        [[sCell playerImageView] setImageWithURLString:sPlayerImageURLString
                                      placeholderImage:[UIImage imageNamed:@"nba_logo.png"]
                                         loadFailImage:[UIImage imageNamed:@"default_player.png"]
                                                option:WebImageOptionSDWebImage
                                             completed:^(NSURL * _Nullable imageURL, UIImage * _Nullable image, NSError * _Nullable error) {
                                                 if (error) {
                                                 } else {
                                                 }
                                             }];

        if (!sPlayerName) {
            AFHTTPSessionManager *sManager = [AFHTTPSessionManager manager];
            NSString *sPlayerBioApiURLString = NBA_PLAYER_BIO_API(sPlayerId);
            [sManager GET:sPlayerBioApiURLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSDictionary *sDic = (NSDictionary *)responseObject;
                NBAVOPlayerBio *sPlayerBio = [[NBAVOPlayerBio alloc] initWithData:[sDic objectForKey:@"Bio"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[sCell playerNameLabel] setText:[sPlayerBio playerName]];
                    [sCell setNeedsLayout];
                });
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NBADebugLog(@"Error: %@", error);
                [[sCell playerNameLabel] setText:@"NONAME"];
                [sCell setNeedsLayout];
            }];
        } else {
            [[sCell playerNameLabel] setText:sPlayerName];
        }
    }
    
    [sCell setNeedsLayout];
    return sCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath {
    return CGSizeMake([aCollectionView bounds].size.width / gStatCollectionViewRowCount, [aCollectionView bounds].size.height / gStatCollectionViewRowCount);
}

@end
