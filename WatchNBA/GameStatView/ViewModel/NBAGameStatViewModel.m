//
//  NBAGameStatViewModel.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameStatViewModel.h"
#import "NBAGameStatTableViewCell.h"
#import "NBAApiUrl.h"
#import "UIImageView+WebImage.h"

@implementation NBAGameStatViewModel {
    NBAVOStatLeader *_vTeamLeaders;
    NBAVOStatLeader *_hTeamLeaders;
}

- (instancetype)initWithGameStat:(NBAVOStat *)aStat {
    self = [super init];
    if (self) {
        _vTeamLeaders = [[aStat vTeam] leaders];
        _hTeamLeaders = [[aStat hTeam] leaders];
    }
    return self;
}

- (instancetype)init {
    return [self initWithGameStat:nil];
}

#pragma mark - Implementation NBAGameTableViewModelProtocol

+ (Class)tableViewCellClass {
    return [NBAGameStatTableViewCell class];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    NBAGameStatTableViewCell *sTabelViewCell = [aTableView dequeueReusableCellWithIdentifier:NSStringFromClass([[self class] tableViewCellClass])];
    [sTabelViewCell setSeparatorInset:UIEdgeInsetsMake(0.f, sTabelViewCell.bounds.size.width, 0.f, 0.f)];
    [sTabelViewCell setupCollectionViewWithvTeamLeadersData:_vTeamLeaders hTeamLeaders:_hTeamLeaders];
    [sTabelViewCell layoutIfNeeded];
    
    return sTabelViewCell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    return [[[self class] tableViewCellClass] tableViewCellHeight];
}

@end
