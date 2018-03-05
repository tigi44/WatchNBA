//
//  NBAVOStat.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAVOStatTeam.h"

@interface NBAVOStat : NSObject

@property(nonatomic, copy)NSString *timesTied;
@property(nonatomic, copy)NSString *leadChanged;
@property(nonatomic, strong)NBAVOStatTeam *vTeam;
@property(nonatomic, strong)NBAVOStatTeam *hTeam;

- (instancetype)initWithData:(NSDictionary *)aData;

@end
