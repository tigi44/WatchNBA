//
//  NBAGameStatViewModel.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAGameTableViewModelProtocol.h"
#import "NBAVOStat.h"

@interface NBAGameStatViewModel : NSObject <NBAGameTableViewModelProtocol>

- (instancetype)initWithGameStat:(NBAVOStat *)aStat;

@end
