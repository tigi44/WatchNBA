//
//  NBAGameStatTableViewCell.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBAVOStatLeader.h"

@interface NBAGameStatTableViewCell : UITableViewCell

- (void)setupCollectionViewWithvTeamLeadersData:(NBAVOStatLeader *)aVTeamLeaders hTeamLeaders:(NBAVOStatLeader *)aHTeamLeaders;
+ (float)tableViewCellHeight;

@end
