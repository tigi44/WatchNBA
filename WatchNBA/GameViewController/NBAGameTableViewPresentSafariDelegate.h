//
//  NBAGameTableViewPresentSafariDelegate.h
//  WatchNBA
//
//  Created by tigi on 2018. 3. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NBAGameTableViewPresentSafariDelegate <NSObject>

- (void)presentSafariViewControllerWithURL:(NSURL *)aURL;

@end
