//
//  NBAGameInfoViewModel.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAGameTableViewModelProtocol.h"
#import "NBAGameTableViewReloadDelegate.h"
#import "NBAVOGame.h"

@interface NBAGameInfoViewModel : NSObject <NBAGameTableViewModelProtocol, NBAGameTableViewReloadDelegate>

- (instancetype)initWithGame:(NBAVOGame *)aGame;

@end
