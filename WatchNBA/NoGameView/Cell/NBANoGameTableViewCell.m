//
//  NBANoGameTableViewCell.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBANoGameTableViewCell.h"
#import "UIView+Layout.h"

@interface NBANoGameTableViewCell()

@property(nonatomic, readwrite) UILabel *noGameLabel;

@end

@implementation NBANoGameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier {
    self = [super initWithStyle:aStyle reuseIdentifier:aReuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor darkGrayColor]];
        [self setupSubview];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [_noGameLabel sizeToFit];
    [_noGameLabel moveToHorizontalCenter];
    [_noGameLabel moveToVerticalCenter];
}

- (void)setupSubview {
    _noGameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_noGameLabel setNumberOfLines:1];
    [_noGameLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [_noGameLabel setTextColor:[UIColor whiteColor]];
    [_noGameLabel setText:@"No Game"];
    [self addSubview:_noGameLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -

+ (float)tableViewCellHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

@end
