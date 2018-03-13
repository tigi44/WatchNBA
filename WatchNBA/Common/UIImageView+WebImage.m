//
//  UIImageView+WebImage.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 22..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

NSString *const WebImageErrorDomain = @"WebImageErrorDomain";

@implementation UIImageView (WebImage)

#pragma mark -
- (void)setImageWithURLString:(nullable NSString *)aURLString
             placeholderImage:(nullable UIImage *)aPlaceholderImage
                loadFailImage:(nullable UIImage *)aLoadFailImage
                       option:(WebImageOption)aOption
                    completed:(nullable WebImageCompletionBlock)aCompledBlock {
    NSURL *sURL = [NSURL URLWithString: aURLString];
    
    switch (aOption) {
        case WebImageOptionDefault:
            [self default_setImageWithURL:sURL placeholderImage:aPlaceholderImage loadFailImage:aLoadFailImage completed:aCompledBlock];
            break;
        case WebImageOptionSDWebImage:
            [self sdWebImage_setImageWithURL:sURL placeholderImage:aPlaceholderImage loadFailImage:aLoadFailImage sdWebImageOption:0 progress:nil completed:aCompledBlock];
            break;
        case WebImageOptionAFNetworking:
        {
            NSMutableURLRequest *sURLRequest = [NSMutableURLRequest requestWithURL:sURL];
            [sURLRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
            [self afNetworking_setImageWithURLRequest:sURLRequest placeholderImage:aPlaceholderImage loadFailImage:aLoadFailImage completed:aCompledBlock];
            break;
        }
    }
}

- (void)setImageWithURLString:(nullable NSString *)aURLString
             placeholderImage:(nullable UIImage *)aPlaceholderImage
                loadFailImage:(nullable UIImage *)aLoadFailImage
                       option:(WebImageOption)aOption
             sdWebImageOption:(SDWebImageOptions)aSDWebImageOption
                     progress:(nullable SDWebImageDownloaderProgressBlock)aProgressBlock
                    completed:(nullable WebImageCompletionBlock)aCompledBlock {
    NSAssert(aOption == WebImageOptionSDWebImage, @"must be WebImageOptionSDWebImage");
    
    NSURL *sURL = [NSURL URLWithString: aURLString];
    [self sdWebImage_setImageWithURL:sURL placeholderImage:aPlaceholderImage loadFailImage:aLoadFailImage sdWebImageOption:aSDWebImageOption progress:aProgressBlock completed:aCompledBlock];
}

- (void)setImageWithURLRequest:(nullable NSURLRequest *)aAFNetworkingURLRequest
              placeholderImage:(nullable UIImage *)aPlaceholderImage
                 loadFailImage:(nullable UIImage *)aLoadFailImage
                        option:(WebImageOption)aOption
                     completed:(nullable WebImageCompletionBlock)aCompledBlock {
    NSAssert(aOption == WebImageOptionAFNetworking, @"must be WebImageOptionAFNetworking");
    
    [self afNetworking_setImageWithURLRequest:aAFNetworkingURLRequest placeholderImage:aPlaceholderImage loadFailImage:aLoadFailImage completed:aCompledBlock];
}

#pragma mark - default
/**
  using GCD

 @param aURL aURL
 @param aPlaceholderImage aPlaceholderImage
 @param aLoadFailImage aLoadFailImage
 @param aCompledBlock aCompledBlock
 */
- (void)default_setImageWithURL:(nullable NSURL *)aURL
               placeholderImage:(nullable UIImage *)aPlaceholderImage
                  loadFailImage:(nullable UIImage *)aLoadFailImage
                      completed:(nullable WebImageCompletionBlock)aCompledBlock {
    if (aPlaceholderImage) {
        [self setImage:aPlaceholderImage];
    }
    
    if (aURL) {
        dispatch_queue_t q_global   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main     = dispatch_get_main_queue();
        
        dispatch_async(q_global, ^{
            UIImage *sImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:aURL]];
            
            dispatch_async(q_main, ^{
                if (sImage) {
                    [self setImage:sImage];
                    aCompledBlock(aURL, sImage, nil);
                } else {
                    if (aLoadFailImage) {
                        [self setImage:aLoadFailImage];
                    }
                    
                    if (aCompledBlock) {
                        NSError *sError = [NSError errorWithDomain:WebImageErrorDomain code:-99 userInfo:@{NSLocalizedDescriptionKey : @"image url load error"}];
                        aCompledBlock(aURL, nil, sError);
                    }
                }
            });
        });
    } else {
        if (aCompledBlock) {
            NSError *sError = [NSError errorWithDomain:WebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            aCompledBlock(nil, nil, sError);
        }
    }
}

#pragma mark - SDWebImage Opensource
/**
 using SDWebImage Opensource

 @param aURL aURL
 @param aPlaceholderImage aPlaceholderImage
 @param aLoadFailImage aLoadFailImage
 @param aSDWebImageOption aSDWebImageOption
 @param aProgressBlock aProgressBlock
 @param aCompledBlock aCompledBlock
 */
- (void)sdWebImage_setImageWithURL:(nullable NSURL *)aURL
                  placeholderImage:(nullable UIImage *)aPlaceholderImage
                     loadFailImage:(nullable UIImage *)aLoadFailImage
                  sdWebImageOption:(SDWebImageOptions)aSDWebImageOption
                          progress:(nullable SDWebImageDownloaderProgressBlock)aProgressBlock
                         completed:(nullable WebImageCompletionBlock)aCompledBlock {
    __weak __typeof(self)weakSelf = self;
    
    [self sd_setImageWithURL:aURL
            placeholderImage:aPlaceholderImage
                     options:aSDWebImageOption
                    progress:aProgressBlock
                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                       if (error) {
                           if ([[error domain] isEqual:SDWebImageErrorDomain] && [error code] == -1) {
                               // if error is about url nil, it doesn't set loadFailImage
                           } else {
                               if (aLoadFailImage) {
                                   [weakSelf setImage:aLoadFailImage];
                               }
                           }
                       }
                       if (aCompledBlock) {
                           aCompledBlock(imageURL, image, error);
                       }
    }];
}

#pragma mark - AFNetworking UIKit Opensource
/**
 using AFNetworking UIKit Opensource

 @param aURLRequest aURLRequest
 @param aPlaceholderImage aPlaceholderImage
 @param aLoadFailImage aLoadFailImage
 @param aCompledBlock aCompledBlock
 */
- (void)afNetworking_setImageWithURLRequest:(nullable NSURLRequest *)aURLRequest
                           placeholderImage:(nullable UIImage *)aPlaceholderImage
                              loadFailImage:(nullable UIImage *)aLoadFailImage
                                  completed:(nullable WebImageCompletionBlock)aCompledBlock {
    __weak __typeof(self)weakSelf = self;
    
    [self setImageWithURLRequest:aURLRequest
                placeholderImage:aPlaceholderImage
                         success:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image) {
                             [weakSelf setImage:image];
                             if (aCompledBlock) {
                                 aCompledBlock(request.URL, image, nil);
                             }
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error) {
                             if (aLoadFailImage) {
                                 [weakSelf setImage:aLoadFailImage];
                             }
                             if (aCompledBlock) {
                                 aCompledBlock(request.URL, nil, error);
                             }
    }];
    
    if (!aURLRequest.URL) {
        if (aCompledBlock) {
            NSError *sError = [NSError errorWithDomain:WebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            aCompledBlock(nil, nil, sError);
        }
    }
}

@end
