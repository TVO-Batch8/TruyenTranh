//
//  PageViewContentChapter.h
//  MangaGeek
//
//  Created by NhatMinh on 7/11/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PageViewContentChapter : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imgviewChapterContent;
@property NSUInteger pageIndex;

@property NSString *imageFile;
@property(strong, nonatomic) NSURL *urlImage;
@property NSData *dataImage;
@property UIImage *image;

@property (strong, nonatomic) NSCache *cacheManager;

@property (strong,nonatomic) NSMutableArray *arrayImageForChapterGot;


@property (weak, nonatomic) IBOutlet UILabel *labelCurrentPageIndex;

@property (weak, nonatomic) IBOutlet UILabel *labelChapterName;
@property (strong,nonatomic) NSString *chapterNameAtIndexGot;

//@property NSUInteger *indexNext;
@property(strong,nonatomic) NSString *chapterIDGot;
@property (strong,nonatomic) NSMutableArray *arrayFavorite;
@property (strong,nonatomic) NSMutableArray *arrayChapterIDFavorite;

@property long int indexNext;
//@property NSUInteger *indexOfCurrentURL;


//- (IBAction)btnClear:(id)sender;

- (IBAction)btnSave:(id)sender;




@end
