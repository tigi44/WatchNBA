//
//  NBAGameStatCollectionViewCell.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameStatCollectionViewCell.h"
#import "UIView+Layout.h"

static const CGSize kPlayerImageSize = {50.f, 50.f};

@interface NBAGameStatCollectionViewCell()

@property(nonatomic, readwrite)UILabel *valueLabel;
@property(nonatomic, readwrite)UIImageView *playerImageView;

@end

@implementation NBAGameStatCollectionViewCell

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        //[self setBackgroundColor:[UIColor blackColor]];
        [self setupSubview];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_playerImageView setSize:kPlayerImageSize];
    [_playerImageView moveToVerticalCenter];
    if (_imageSideOption == ImageSideLeft) {
        [_playerImageView setXPosition:10.f];
    } else if (_imageSideOption == ImageSideRight) {
        [_playerImageView moveToRightWithMargin:10.f];
    } else {
        [_playerImageView setHidden:YES];
    }
    
    [_valueLabel sizeToFit];
    [_valueLabel moveToVerticalCenter];
    if (_imageSideOption == ImageSideLeft) {
        [_valueLabel moveToRightWithMargin:10.f];
    } else if (_imageSideOption == ImageSideRight) {
        [_valueLabel setXPosition:10.f];
    } else {
        [_valueLabel moveToHorizontalCenter];
        [_valueLabel setTextColor:[UIColor blackColor]];
    }
}

- (void)setupSubview {
    _playerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_playerImageView setContentMode:UIViewContentModeScaleAspectFill];
    [[self contentView] addSubview:_playerImageView];
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_valueLabel setNumberOfLines:1];
    [_valueLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_valueLabel setTextColor:[UIColor whiteColor]];
    [[self contentView] addSubview:_valueLabel];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_valueLabel setText:@""];
    [_valueLabel setTextColor:[UIColor whiteColor]];
    [_playerImageView setImage:nil];
    [_playerImageView setHidden:NO];
}

@end
