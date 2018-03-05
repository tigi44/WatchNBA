//
//  NBAVOTeam.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBAVOTeam : NSObject

@property(nonatomic, copy)NSString *teamId;
@property(nonatomic, copy)NSString *triCode;
@property(nonatomic, copy)NSString *win;
@property(nonatomic, copy)NSString *loss;
@property(nonatomic, copy)NSString *seriesWin;
@property(nonatomic, copy)NSString *seriesLoss;
@property(nonatomic, copy)NSString *score;

- (instancetype)initWithData:(NSDictionary *)aTeamData;

@end
