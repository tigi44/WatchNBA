//
//  NBAGameViewController.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 21..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameViewController.h"
#import "NBAGameInfoViewModel.h"
#import "NBAGameStatViewModel.h"
#import "NBANoGameViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "NBAApiUrl.h"
#import "NBAGameTableViewReloadDelegate.h"

const static NSTimeInterval gGameReloadTimeInterval = 0.05;
const static NSInteger gBefoeGameTimeIntervalWeight = 6;

@interface NBAGameViewController() <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy) NBAVOGame *game;
@property(nonatomic, copy) NBAVOStat *stat;
@property(nonatomic, readwrite) NSInteger index;

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, readwrite) UIRefreshControl *refreshControl;

@property(nonatomic, weak)id<NBAGameTableViewReloadDelegate> tableViewReloadDelegate;

@end

@implementation NBAGameViewController {
    NSArray<id<NBAGameTableViewModelProtocol>> *_viewModels;
    NSTimer *_reloadTimer;
    float _reloadTime;
    float _reloadCurrentTime;
}

- (instancetype)initWithGameData:(NSDictionary *)aData index:(NSInteger)aIndex {
    self = [super init];
    if (self) {
        _game = [[NBAVOGame alloc] initWithData:aData];
        _index = aIndex;
    }
    return self;
}

- (instancetype)init {
    return [self initWithGameData:nil index:0];
}

- (void)loadView {
    [self setupViewModel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    
    [_tableView registerClass:[[NBAGameInfoViewModel class] tableViewCellClass] forCellReuseIdentifier:NSStringFromClass([[NBAGameInfoViewModel class] tableViewCellClass])];
    [_tableView registerClass:[[NBAGameStatViewModel class] tableViewCellClass] forCellReuseIdentifier:NSStringFromClass([[NBAGameStatViewModel class] tableViewCellClass])];
    [_tableView registerClass:[[NBANoGameViewModel class] tableViewCellClass] forCellReuseIdentifier:NSStringFromClass([[NBANoGameViewModel class] tableViewCellClass])];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setAllowsSelection:NO];
    [_tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    [[_tableView layer] setBorderWidth:0.f];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView setSeparatorColor:COLOR_STATIC];
    
    // refresh control for the table view
    [self setRefreshControl:[[UIRefreshControl alloc] init]];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:@"Pull to Refresh"]];
    [_tableView setRefreshControl:_refreshControl];

    [self setView:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadGameData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupReloadTimer];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopReloadTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark - Implements UITableViewDataSource Methods.

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection {
    return [_viewModels count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    id<NBAGameTableViewModelProtocol> sViewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    
    if ([sViewModel conformsToProtocol:@protocol(NBAGameTableViewReloadDelegate)]) {
        [self setTableViewReloadDelegate:(id<NBAGameTableViewReloadDelegate>)sViewModel];
    }
    
    if ([sViewModel conformsToProtocol:@protocol(NBAGameTableViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [sViewModel tableView:aTableView cellForRowAtIndexPath:aIndexPath];
    }
    return nil;
}

#pragma mark - Implements UITableViewDelegate Methods.

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    id<NBAGameTableViewModelProtocol> sViewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    if ([sViewModel conformsToProtocol:@protocol(NBAGameTableViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [sViewModel tableView:aTableView heightForRowAtIndexPath:aIndexPath];
    }
    return 0;
}

#pragma mark - methods for refresh control

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
        if ([_refreshControl isRefreshing]) {
            [_refreshControl endRefreshing];
            [self stopReloadTimer];
            [self reloadGameData];
            [self setupReloadTimer];
        }
}

#pragma mark -

- (void)setupViewModel {
    _viewModels = [NSArray array];
    if (_game) {
        _viewModels = @[[[NBAGameInfoViewModel alloc] initWithGame:_game], [[NBAGameStatViewModel alloc] initWithGameStat:_stat]];
    } else {
        _viewModels = @[[[NBANoGameViewModel alloc] init]];
    }
}

- (void)setupViewModelGame:(NBAVOGame *)aGame stat:(NBAVOStat *)aStat {
    _game = aGame;
    _stat = aStat;
    [self setupViewModel];
    [_tableView reloadData];
}

- (void)setupReloadTimer {
    _reloadCurrentTime = 0;
    if (_game) {
        if ([_game isGameEnded]) {
            [self stopReloadTimer];
        } else {
            if (!_reloadTimer) {
                if ([_game isGameActivated]) {
                    _reloadTime = gNbaApiReloadTime;
                } else {
                    _reloadTime = gNbaApiReloadTime;
                    _reloadTime *= gBefoeGameTimeIntervalWeight;
                }
                _reloadTimer = [NSTimer scheduledTimerWithTimeInterval:gGameReloadTimeInterval target:self selector:@selector(reloadCount) userInfo:nil repeats:YES];
            }
        }
    } else {
        [self stopReloadTimer];
    }
}

- (void)stopReloadTimer {
    if (_reloadTimer) {
        if (_tableViewReloadDelegate) {
            [_tableViewReloadDelegate reloadProgress:0];
        }
        [_reloadTimer invalidate];
        _reloadTimer = nil;
    }
}

- (void)reloadCount {
    if (_tableViewReloadDelegate) {
        if (_reloadCurrentTime <= 0) {
            _reloadCurrentTime = _reloadTime;
        }
        
        _reloadCurrentTime -= gGameReloadTimeInterval;
        float sProgress = 1 - ((float)_reloadCurrentTime/_reloadTime);
        [_tableViewReloadDelegate reloadProgress:sProgress];
        
        if (sProgress >= 1) {
            [self stopReloadTimer];
            [self reloadGameData];
            [self setupReloadTimer];
            [_tableViewReloadDelegate reloadProgress:0];
        }
    } else {
        [self stopReloadTimer];
    }
}

- (void)reloadGameData {
    NSString *sUrlString = NBA_BOX_SCORE_API([_game startDateEastern], [_game gameId]);
    AFHTTPSessionManager *sManager = [AFHTTPSessionManager manager];
    [sManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [sManager GET:sUrlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NBADebugLog(@"reload GameId : %@", [_game gameId]);
        NSDictionary *sDic = (NSDictionary *)responseObject;
        NBAVOGame *sGame = [[NBAVOGame alloc] initWithData:sDic[@"basicGameData"]];
        NBAVOStat *sStat = [[NBAVOStat alloc] initWithData:sDic[@"stats"]];
        [self setupViewModelGame:sGame stat:sStat];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NBADebugLog(@"Error: %@", error);
        [self setupViewModelGame:nil stat:nil];
    }];
}

- (void)reloadGameData_ex {
    NSString *sUrlString = NBA_BOX_SCORE_API([_game startDateEastern], [_game gameId]);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:sUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NBADebugLog(@"Error: %@", error);
            [self setupViewModelGame:nil stat:nil];
        } else {
            NBADebugLog(@"reload GameId : %@", [_game gameId]);
            NSDictionary *sDic = (NSDictionary *)responseObject;
            NBAVOGame *sGame = [[NBAVOGame alloc] initWithData:sDic[@"basicGameData"]];
            NBAVOStat *sStat = [[NBAVOStat alloc] initWithData:sDic[@"stats"]];
            [self setupViewModelGame:sGame stat:sStat];
        }
    }];
    
    [dataTask resume];
}

@end
