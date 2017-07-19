//
//  UIImageView+YYImage.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletedBlock)(UIImage *image, NSError *error, NSURL *imageURL,BOOL memoryCache);
typedef void(^LoadSuccessBlock)(UIImage *image, NSURL *imageURL);
typedef void(^LoadFailureBlock)(NSError *error);
typedef void(^LoadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

@interface UIImageView (YYImage)

/**
 *  异步加载图片
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图片
 */
- (void)loadImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
/**
 *  异步加载图片提供缓存的placeholder image
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图
 */
- (void)loadImageWithPreviousImageURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
/**
 *  异步加载带圆角图片
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图片
 */
- (void)loadCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
/**
 *  异步加载带圆角图片提供缓存的placeholder image
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图片
 */
- (void)loadCircleImageWithPreviousImageURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
/**
 *  异步加载带圆角图片提供缓存 回调
 *
 *  @param url         url
 *  @param placeholder 背景图
 *  @param completed   加载完成回调
 */

- (void)loadCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(CompletedBlock)completed;

/**
 *  异步加载图片
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图片
 *  @param completed   加载完成后要做的任务
 */
- (void)loadImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(CompletedBlock)completed;
/**
 *  加载图片并处理
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图片
 */
- (void)loadYYWebImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(CompletedBlock)completed;
- (void)loadYYWebImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
- (void)loadAvatarImageWithURL:(NSString *)url
              placeholderImage:(UIImage *)placeholder
                       success:(LoadSuccessBlock)success
                       failure:(LoadFailureBlock)failure
                      received:(LoadProgressBlock)progress;
/**
 *  异步加载图片显示加载进度
 *
 *  @param url         图片url
 *  @param placeholder 加载图片时的背景图片
 *  @param success     加载成功的block
 *  @param failure     加载失败的block
 *  @param progress    加载进度显示的block
 */
- (void)loadImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder success:(LoadSuccessBlock)success failure:(LoadFailureBlock)failure received:(LoadProgressBlock)progress;

@end
