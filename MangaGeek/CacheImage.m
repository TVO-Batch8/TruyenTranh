//
//  CacheImage.m
//  MangaGeek
//
//  Created by NhatMinh on 7/15/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "CacheImage.h"
#import <CommonCrypto/CommonDigest.h>

@interface CacheImage()

/**
 * Cache property
 * We should user NSCache instead of NSDictionary for caching because It has higher performance and support limit cost
 */
@property (strong, nonatomic) NSCache *memoryCache;

@property (strong, nonatomic) NSString *diskCachePath;

@end

@implementation CacheImage

+ (id)sharedCacheImage {
    static dispatch_once_t predicate;
    static CacheImage *instance = nil;
    dispatch_once(&predicate, ^{instance = [[self alloc] init];});
    
    return instance;
}

#pragma mark - Override methods

- (instancetype)init {
    self = [super init];
    
    if (self) {
        // Init data
        _memoryCache = [[NSCache alloc] init];
        self.memoryCache.countLimit = 100; // Default we will cache 20 images on memory
        
        // Can set this property to limit memory size: ex we will limit 10Mb
        // self.memoryCache.totalCostLimit = 10 * 1024 * 1024; // Unit is byte
        
        // Get disk cache path. It will be: /Library/Caches/CacheImage
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:@"CacheImage"];
        
        NSLog(@"Disk path: %@ **", self.diskCachePath);
        
        // Should handle memory warning notification. We should reduce memory in this case
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notificationDidReceiveMemoryWarning)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    
    return self;
}
#pragma mark - Notification services

- (void)notificationDidReceiveMemoryWarning {
    NSLog(@"Received memory warning. Auto clear all memory cache for reduce memory.");
    
    // Should clear all memory cache
    [self clearMemoryCache];
}

#pragma mark - Private methods

/**
 * Method support create new cache key from url
 * We will create unique string from url by convert it to MD5 string
 */
- (NSString *)cacheKeyWithURL:(NSURL *)url {
    const char *str = [url.absoluteString UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    
    NSString *md5String =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5String;
}
//*********  Get image from cache with url ***************
//*********  Get image from cache with url ***************

- (UIImage *)getImageFromCacheWithURL:(NSURL *)url {
    NSString *cacheKey = [self cacheKeyWithURL:url];
    
    // First try to get in memory cache
    UIImage *image = [self.memoryCache objectForKey:cacheKey];
    
    // If have no image on memory cache, we will get from disk and save it on memory cache
    if (!image) {
        NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:[self cacheKeyWithURL:url]];
        image = [UIImage imageWithContentsOfFile:filePath];
        
        // Save on memory cache after load from disk
        if (image) {
            [self.memoryCache setObject:image forKey:cacheKey];
        }
    }
    
    return image;
}
//******** Save image to cache and local disk ***********************//
//******** Save image to cache and local disk ***********************//

- (void)saveImage:(UIImage *)image toCacheWithURL:(NSURL *)url {
    NSString *cacheKey = [self cacheKeyWithURL:url];
    
    // Save on memory cache
    [self.memoryCache setObject:image forKey:cacheKey];
    
    NSLog(@"******* save iamge on cache  ");
    
    // Save on local disk
    
//    // Create cache folder if is not exist
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    if (![fileManager fileExistsAtPath:self.diskCachePath]) {
//        [fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    // Now save image data of that folder
//    NSString *saveFilePath = [self.diskCachePath stringByAppendingPathComponent:cacheKey];
//    
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
//    [imageData writeToFile:saveFilePath atomically:YES];
    
   }

- (void)loadImageWithURL:(NSURL *)url completed:(void (^)(UIImage *, NSError *))completed {
    if (!completed || completed == NULL) {
        // Do nothing if is not completed block
        return;
    }
    /**
     * Try to get image from cache, if null, we will download this image
     * This operation should be excute on background task
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *resultImage = [self getImageFromCacheWithURL:url];
        
        if (resultImage) {
            
            // Callback completed to UI
            dispatch_async(dispatch_get_main_queue(), ^{
                completed(resultImage, nil);
            });
        } else {
            
            // Try to download image from network
            // It's very simple by use NSData's method (should use NSURLConnection or NSURLSession for hight level using)
            NSError *error = nil;
            
            NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
            
            if (data && error == nil) {
                resultImage = [UIImage imageWithData:data];
                
                // save image to cache
                [self saveImage:resultImage toCacheWithURL:url];
                
                // Callback completed to UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    completed(resultImage, nil);
                });
            } else {
                
                // Error
                dispatch_async(dispatch_get_main_queue(), ^{
                    completed(nil, error);
                });
            }
        }
    });
}


- (void)clearMemoryCache {
    [self.memoryCache removeAllObjects];
    NSLog(@"Clear Memory Cache");
}

- (void)clearDiskCache {
    [[NSFileManager defaultManager] removeItemAtPath:self.diskCachePath error:nil];
    NSLog(@"Clear diskCache");
}

- (void)clearAllCache {
    [self clearMemoryCache];
    [self clearDiskCache];
}


// ********** EDITED *********

- (void)saveOndisk:(NSURL *)url {
    
    NSString *cacheKey = [self cacheKeyWithURL:url];

    
    // Save on local disk
    
    // First try to get in memory cache
        UIImage *image = [self.memoryCache objectForKey:cacheKey];
    
    if (!image) {
        NSLog(@" \a \a\a\a\a\a  ko ton tai cai image nay trong cache");
    }
    else{
        // Create cache folder if is not exist
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:self.diskCachePath]) {
            [fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        // Now save image data of that folder
        NSString *saveFilePath = [self.diskCachePath stringByAppendingPathComponent:cacheKey];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
        [imageData writeToFile:saveFilePath atomically:YES];
        
    }
    
    
}

- (BOOL)checkImageOndisk:(NSURL *)url{
    //NSString *cacheKey = [self cacheKeyWithURL:url];
    
    // First try to get in memory cache
//    UIImage *image = [self.memoryCache objectForKey:cacheKey];
//    
//    // If have no image on memory cache, we will get from disk and save it on memory cache
//    if (!image) {
//        NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:[self cacheKeyWithURL:url]];
//        image = [UIImage imageWithContentsOfFile:filePath];
//        
//    }
    NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:[self cacheKeyWithURL:url]];
    UIImage *image=[UIImage imageWithContentsOfFile:filePath];
    
    if (image) {
        return YES;
    }
    else
    {
        return NO;
    }
        
    
}
- (void)deleteFileOnDiskWithURL:(NSURL *)url{
    
    NSString *cacheKey = [self cacheKeyWithURL:url];
    NSString *filePathString =[self.diskCachePath stringByAppendingPathComponent:cacheKey];
    NSURL *filePath=[NSURL fileURLWithPath:filePathString];
    
    NSError *error = nil;
    
    [[NSFileManager defaultManager] removeItemAtURL:filePath error:&error];
    NSLog(@"***** Delete successed : %@",filePath);
    
}


@end















