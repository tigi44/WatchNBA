//
//  UIImageView+WebImage.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 22..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageManager.h>

typedef NS_ENUM(NSUInteger, WebImageOption)
{
    // no cache
    WebImageOptionDefault = 0,
    
    // memory, disk cache
    WebImageOptionSDWebImage,
    
    // memory cache
    WebImageOptionAFNetworking
};

typedef void(^WebImageCompletionBlock)(NSURL * _Nullable imageURL, UIImage * _Nullable image, NSError * _Nullable error);

@interface UIImageView (WebImage)

- (void)setImageWithURLString:(nullable NSString *)aURLString
             placeholderImage:(nullable UIImage *)aPlaceholderImage
                loadFailImage:(nullable UIImage *)aLoadFailImage
                       option:(WebImageOption)aOption
                    completed:(nullable WebImageCompletionBlock)aCompledBlock;

/**
 SDWebImage/UIImageView+WebCache.h
 
 - can use 'SDWebImageOptions', 'SDWebImageDownloaderProgressBlock'
 */
- (void)setImageWithURLString:(nullable NSString *)aURLString
             placeholderImage:(nullable UIImage *)aPlaceholderImage
                loadFailImage:(nullable UIImage *)aLoadFailImage
                       option:(WebImageOption)aOption
             sdWebImageOption:(SDWebImageOptions)aSDWebImageOption
                     progress:(nullable SDWebImageDownloaderProgressBlock)aProgressBlock
                    completed:(nullable WebImageCompletionBlock)aCompledBlock;

/**
 AFNetworking/UIImageView+AFNetworking.h
 
 - can use 'NSURLRequest', customizing request (NSURLCache, NSURLRequest cachePolicy ....)
 */
- (void)setImageWithURLRequest:(nullable NSURLRequest *)aAFNetworkingURLRequest
              placeholderImage:(nullable UIImage *)aPlaceholderImage
                 loadFailImage:(nullable UIImage *)aLoadFailImage
                        option:(WebImageOption)aOption
                     completed:(nullable WebImageCompletionBlock)aCompledBlock;

@end
