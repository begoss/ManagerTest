//
//  UIImageView+YYImage.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//


#import <YYWebImage.h>
#import "UIImage+Circle.h"

@implementation UIImageView (YYImage)

- (void)loadImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder {
    [self loadYYWebImageWithURL:url placeholderImage:placeholder];
}

-(void)loadImageWithPreviousImageURL:(NSString *)url placeholderImage:(UIImage *)placeholder{
    NSString *key = [[YYWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
    UIImage *previousImage = [[YYWebImageManager sharedManager].cache getImageForKey:key];
    [self loadYYWebImageWithURL:url placeholderImage:previousImage?previousImage:placeholder];
}

- (void)loadCircleImageWithPreviousImageURL:(NSString *)url placeholderImage:(UIImage *)placeholder{
    NSString *key = [[YYWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
    UIImage *previousImage = [[YYWebImageManager sharedManager].cache getImageForKey:key];
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:previousImage?previousImage:placeholder options:kNilOptions manager:nil progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return [image imageWithCirle];
    } completion:nil];
}
- (void)loadCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder{
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation manager:nil progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return [image imageWithCirle];
    } completion:nil];
}
- (void)loadCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(CompletedBlock)completed; {
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:kNilOptions manager:nil progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return [image imageWithCirle];
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) {
            completed(image,error,url,NO);
        }
    }];
}
- (void)loadImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(CompletedBlock)completed {
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation manager:nil progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) {
            completed(image, error, url, from == YYWebImageFromMemoryCache);
        }
    }];
    
}
- (void)loadAvatarImageWithURL:(NSString *)url
              placeholderImage:(UIImage *)placeholder
                       success:(LoadSuccessBlock)success
                       failure:(LoadFailureBlock)failure
                      received:(LoadProgressBlock)progress{
    
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionIgnoreDiskCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (receivedSize && expectedSize) {
            progress(receivedSize, expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else {
            success(image, url);
        }
    }];
}

- (void)loadYYWebImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder {
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
}

- (void)loadYYWebImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(CompletedBlock)completed {
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionAvoidSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) {
            completed(image,error,url,NO);
        }
    }];
}

- (void)loadImageWithURL:(NSString *)url
        placeholderImage:(UIImage *)placeholder
                 success:(LoadSuccessBlock)success
                 failure:(LoadFailureBlock)failure
                received:(LoadProgressBlock)progress {
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (receivedSize && expectedSize) {
            progress(receivedSize, expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else {
            success(image, url);
        }
    }];
}

@end
