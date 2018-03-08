//
//  NBAVOPlayer.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOPlayer.h"
#import "NBAVOPlayerBio.h"
#import "NBAApiUrl.h"
#import <AFNetworking/AFNetworking.h>

@interface NBAVOPlayer()

@property(nonatomic, readwrite)NBAVOPlayerBio *playerBio;

@end

@implementation NBAVOPlayer

- (instancetype)initWithData:(NSDictionary *)aPersonData {
    self = [super init];
    if (self) {
        _personId = aPersonData[@"personId"];
        //[self playerBioByPlayerId];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

- (void)playerBioByPlayerId {
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *sManager = [AFHTTPSessionManager manager];
    NSString *sPlayerBioApiURLString = NBA_PLAYER_BIO_API(_personId);
    [sManager GET:sPlayerBioApiURLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *sDic = (NSDictionary *)responseObject;
        NBAVOPlayerBio *sPlayerBio = [[NBAVOPlayerBio alloc] initWithData:[sDic objectForKey:@"Bio"]];
        [weakSelf setPlayerBio:sPlayerBio];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NBADebugLog(@"Error: %@", error);
        NBAVOPlayerBio *sPlayerBio = [[NBAVOPlayerBio alloc] init];
        [weakSelf setPlayerBio:sPlayerBio];
    }];
}
@end
