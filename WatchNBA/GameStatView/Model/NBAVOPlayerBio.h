//
//  NBAVOPlayerBio.h
//  WatchNBA
//
//  Created by tigi on 2018. 3. 8..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBAVOPlayerBio : NSObject

@property(nonatomic, copy)NSString *playerId;
@property(nonatomic, copy)NSString *playerName;
@property(nonatomic, copy)NSString *professional;
@property(nonatomic, copy)NSString *colleage;
@property(nonatomic, copy)NSString *highschool;
@property(nonatomic, copy)NSString *twitter;

- (instancetype)initWithData:(NSDictionary *)aData;

@end
