//
//  CacheImage.h
//  MangaGeek
//
//  Created by NhatMinh on 7/15/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CacheImage : NSObject

+ (id)sharedCacheImage;

// Method download and cache image
- (void)loadImageWithURL:(NSURL *)url completed:(void(^)(UIImage *image, NSError *error))completed;

// Clear cache
- (void)clearMemoryCache;
- (void)clearDiskCache;
- (void)clearAllCache; // Clear both memory and disk cache
- (void)saveOndisk:(NSURL *)url;
- (BOOL)checkImageOndisk:(NSURL *)url;
- (void)deleteFileOnDiskWithURL:(NSURL *)url;

@end
