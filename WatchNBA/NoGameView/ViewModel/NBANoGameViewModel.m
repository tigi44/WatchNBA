//
//  NBANoGameViewModel.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBANoGameViewModel.h"
#import "NBANoGameTableViewCell.h"

@interface NBANoGameViewModel()
@end

@implementation NBANoGameViewModel

+ (Class)tableViewCellClass {
    return [NBANoGameTableViewCell class];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    NBANoGameTableViewCell *sTabelViewCell = [aTableView dequeueReusableCellWithIdentifier:NSStringFromClass([[self class] tableViewCellClass])];
    return sTabelViewCell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    return [[[self class] tableViewCellClass] tableViewCellHeight];
}

@end
