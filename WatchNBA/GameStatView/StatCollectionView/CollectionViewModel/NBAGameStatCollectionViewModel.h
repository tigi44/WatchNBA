//
//  NBAGameStatCollectionViewModel.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBAGameStatCollectionViewModelProtocol.h"
#import "NBAVOStatLeader.h"
#import "NBAGameStatCollectionViewCell.h"

@interface NBAGameStatCollectionViewModel : NSObject <NBAGameStatCollectionViewModelProtocol>

- (instancetype)initWithTeamLeadersData:(NBAVOStatLeader *)aTeamLeaders imageSideOption:(NBAGameStatCollectionViewCellImageSideOption) aImageSideOption;

- (instancetype)initWithLabelData;

@end
