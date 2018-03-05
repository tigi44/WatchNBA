//
//  ViewController.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 20..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "NBAGameViewController.h"
#import "NBAApiUrl.h"
#import <AFNetworking/AFNetworking.h>
#import <PromiseKit/PromiseKit.h>
#import "NBAVOGame.h"

@interface ViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong) UIPageViewController *pageViewController;
@property(nonatomic, assign) NSInteger numGames;
@property(nonatomic, strong) NSArray<NSDictionary *> *games;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
    [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
//        NSString *sURLString = NBA_YESTERDAY_SCOREBOARD_API;
//        [self setupGamesByURLString:sURLString promiseResolver:resolver];
        resolver(nil);
    }].then(^(id object) {
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
            NSString *sURLString = NBA_TODAY_SCOREBOARD_API;
            [self setupGamesByURLString:sURLString promiseResolver:resolver];
        }];
    }).then(^(id object) {
        [self setupPageViewController];
    });
}

#pragma mark -

- (void)setup {
    _numGames = 0;
    _games = [NSArray array];
}

- (void)setupGamesByURLString:(NSString *)aURLString promiseResolver:(PMKResolver)aResolver {
    AFHTTPSessionManager *sManager = [AFHTTPSessionManager manager];
    [sManager GET:aURLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *sDic = (NSDictionary *)responseObject;
        NSInteger sNumGame = [[sDic objectForKey:@"numGames"] integerValue];
        NSArray<NSDictionary *> *sGames = [sDic objectForKey:@"games"];
        
        _numGames += sNumGame;
        _games = [_games arrayByAddingObjectsFromArray:sGames];
        
        aResolver(sGames);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
       
        NSLog(@"Error: %@", error);
    }];
}

- (void)setupPageViewController {
    [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil]];
    [_pageViewController setDataSource:self];
    [_pageViewController setDelegate:self];
    [[_pageViewController view] setFrame:[[self view] bounds]];
    
    NSArray *sViewControllers = [NSArray arrayWithObject:[self viewControllerAtIndex:0]];
    [_pageViewController setViewControllers:sViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:_pageViewController];
    [[self view] addSubview:[_pageViewController view]];
    [_pageViewController didMoveToParentViewController:self];
}

- (NBAGameViewController *)viewControllerAtIndex:(NSUInteger)aIndex {
    if (_games && [_games count] > aIndex)
    {
        NBAVOGame *sGame = [[NBAVOGame alloc] initWithData:_games[aIndex]];
        return [[NBAGameViewController alloc] initWithGame:sGame index:aIndex];
    }
    else
    {
        return [[NBAGameViewController alloc] init];
    }
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)aPageViewController viewControllerAfterViewController:(UIViewController *)aViewController {
    NSUInteger sIndex = [(NBAGameViewController *)aViewController index];
    if (_numGames == 0 || sIndex == (_numGames - 1))
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:++sIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)aPageViewController viewControllerBeforeViewController:(UIViewController *)aViewController {
    NSUInteger sIndex = [(NBAGameViewController *)aViewController index];
    if (sIndex == 0)
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:--sIndex];
}

@end
