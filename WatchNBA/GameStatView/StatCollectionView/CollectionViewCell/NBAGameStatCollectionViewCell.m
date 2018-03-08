//
//  NBAGameStatCollectionViewCell.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameStatCollectionViewCell.h"
#import "UIView+Layout.h"
#import "NBAApiUrl.h"

static const CGSize kPlayerImageSize = {50.f, 50.f};
static const float kPlayerStatGap = 10.f;

@interface NBAGameStatCollectionViewCell()

@property(nonatomic, readwrite)UILabel *valueLabel;
@property(nonatomic, readwrite)UIImageView *playerImageView;
@property(nonatomic, readwrite)UILabel *playerNameLabel;

@end

@implementation NBAGameStatCollectionViewCell

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:COLOR_BACKGROUND];
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
        [_playerImageView setXPosition:kPlayerStatGap];
    } else if (_imageSideOption == ImageSideRight) {
        [_playerImageView moveToRightWithMargin:kPlayerStatGap];
    } else {
        [_playerImageView setHidden:YES];
    }
    
    [_playerNameLabel sizeToFit];
    [_playerNameLabel setWidth:self.frame.size.width];
    [_playerNameLabel moveToBottomOf:_playerImageView gap:kPlayerStatGap];
    [_playerNameLabel setXPosition:0];
    [_playerNameLabel setTextAlignment:NSTextAlignmentCenter];
    //[_playerNameLabel setXPosition:_playerImageView.frame.origin.x + kPlayerImageSize.width / 2 - _playerNameLabel.frame.size.width / 2];
    if (_imageSideOption == ImageSideLeft) {
//        if (_playerNameLabel.frame.origin.x < 0) {
//            [_playerNameLabel setXPosition:0];
//        }
    } else if (_imageSideOption == ImageSideRight) {
//        if (_playerNameLabel.frame.origin.x + _playerNameLabel.frame.size.width > self.frame.size.width ) {
//            [_playerNameLabel setXPosition:0];
//        }
    } else {
        [_playerImageView setHidden:YES];
    }
    
    [_valueLabel sizeToFit];
    [_valueLabel setTextColor:COLOR_TEXT];
    [_valueLabel moveToVerticalCenter];
    if (_imageSideOption == ImageSideLeft) {
        [_valueLabel moveToRightWithMargin:kPlayerStatGap];
    } else if (_imageSideOption == ImageSideRight) {
        [_valueLabel setXPosition:kPlayerStatGap];
    } else {
        [_valueLabel moveToHorizontalCenter];
        [_valueLabel setTextColor:COLOR_STATIC];
    }
}

- (void)setupSubview {
    _playerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_playerImageView setContentMode:UIViewContentModeScaleAspectFill];
    [[self contentView] addSubview:_playerImageView];
    
    _playerNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_playerNameLabel setNumberOfLines:2];
    [_playerNameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [_playerNameLabel setTextColor:COLOR_TEXT];
    [[self contentView] addSubview:_playerNameLabel];
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_valueLabel setNumberOfLines:1];
    [_valueLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_valueLabel setTextColor:COLOR_TEXT];
    [[self contentView] addSubview:_valueLabel];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_valueLabel setText:@""];
    [_valueLabel setTextColor:COLOR_BACKGROUND];
    [_playerNameLabel setText:@""];
    [_playerNameLabel setHidden:NO];
    [_playerImageView setImage:nil];
    [_playerImageView setHidden:NO];
}

@end
