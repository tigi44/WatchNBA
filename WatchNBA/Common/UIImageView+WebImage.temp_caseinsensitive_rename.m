//
//  UIImageView+webImage.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 22..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIImageView+webImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation UIImageView (webImage)

#pragma mark -
- (void)setImageWithUrlString:(nullable NSString *)aURL
             placeholderImage:(nullable UIImage *)aPlaceholderImage
                loadFailImage:(nullable UIImage *)aLoadFailImage
                       option:(WEBImageOption)aOption
                    completed:(nullable WEBImageCompletionBlock)aCompledBlock {
    NSURL *sUrl = [NSURL URLWithString: aURL];
    
    switch (aOption) {
        case WEBImageOptionDefault:
            [self setImageWithURL:sUrl placeholderImage:nil loadFailImage:nil completed:nil];
            break;
        case WEBImageOptionBySDWebImage:
            [self sdWebImage_setImageWithURL:sUrl placeholderImage:nil loadFailImage:nil completed:nil];
            break;
        case WEBImageOptionByAFNetworking:
            [self afNetworking_setImageWithURL:sUrl placeholderImage:nil loadFailImage:nil completed:nil];
            break;
    }
}

#pragma mark -
/**
 using GCD

 @param aURL aURL
 @param aPlaceholderImage aPlaceholderImage
 @param aLoadFailImage aLoadFailImage
 @param aCompledBlock aCompledBlock
 */
- (void)setImageWithURL:(nullable NSURL *)aURL
       placeholderImage:(nullable UIImage *)aPlaceholderImage
          loadFailImage:(nullable UIImage *)aLoadFailImage
              completed:(nullable WEBImageCompletionBlock)aCompledBlock {
    dispatch_queue_t q_global   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main     = dispatch_get_main_queue();
    
    dispatch_async(q_global, ^{
        UIImage *sImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:aURL]];
        
        dispatch_async(q_main, ^{
            [self setImage:sImage];
        });
    });
}

#pragma mark - SDWebImage Opensource
/**
 using SDWebImage Opensource

 @param aURL aURL
 @param aPlaceholderImage aPlaceholderImage
 @param aLoadFailImage aLoadFailImage
 @param aCompledBlock aCompledBlock
 */
- (void)sdWebImage_setImageWithURL:(nullable NSURL *)aURL
                  placeholderImage:(nullable UIImage *)aPlaceholderImage
                     loadFailImage:(nullable UIImage *)aLoadFailImage
                         completed:(nullable WEBImageCompletionBlock)aCompledBlock {
    [self sd_setImageWithURL:aURL placeholderImage:aPlaceholderImage options:0 progress:nil completed:nil];
}

#pragma mark - AFNetworking UIKit Opensource
/**
 using AFNetworking UIKit Opensource

 @param aURL aURL
 @param aPlaceholderImage aPlaceholderImage
 @param aLoadFailImage aLoadFailImage
 @param aCompledBlock aCompledBlock
 */
- (void)afNetworking_setImageWithURL:(nullable NSURL *)aURL
                    placeholderImage:(nullable UIImage *)aPlaceholderImage
                       loadFailImage:(nullable UIImage *)aLoadFailImage
                           completed:(nullable WEBImageCompletionBlock)aCompledBlock {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aURL];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
//    //disk caching
//    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]
//                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                              timeoutInterval:60];
    
    [self setImageWithURLRequest:request placeholderImage:aPlaceholderImage success:nil failure:nil];
}

//- (void)requestProfileImageWithURL:(NSString *)aURL imageView:(UIImageView *)aImageView
//{
//    [aImageView setShowActivityIndicatorView:YES];
//    [aImageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [aImageView sd_setImageWithURL:[NSURL URLWithString:[aURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (error != nil) {
//            return;
//        }
//
//        [[aImageView layer] removeAllAnimations];
//        CATransition *sTransition = [CATransition animation];
//        [sTransition setType:kCATransitionFade];
//        [sTransition setDuration:0.5];
//        [sTransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [[aImageView layer] addAnimation:sTransition forKey:[@([aImageView hash]) stringValue]];
//
//    }];
//}

@end
