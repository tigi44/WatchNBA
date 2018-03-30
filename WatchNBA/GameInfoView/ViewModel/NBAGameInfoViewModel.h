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
#import "NBAGameTableViewPresentSafariDelegate.h"
#import "NBAVOGame.h"

@interface NBAGameInfoViewModel : NSObject <NBAGameTableViewModelProtocol, NBAGameTableViewReloadDelegate>

@property (nonatomic, weak) id<NBAGameTableViewPresentSafariDelegate> presentSafariDelegate;

- (instancetype)initWithGame:(NBAVOGame *)aGame;

@end
