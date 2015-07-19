//
//  ListChapter.h
//  MangaGeek
//
//  Created by NhatMinh on 7/10/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CustomTableCell.h"
#import "TestContent.h"
#import "CacheImage.h"

@interface ListChapter : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableListChapter;
@property (strong,nonatomic) NSMutableArray * arrayThumbailgot;
@property (strong,nonatomic) NSMutableArray *arrayMangaNameGot;
@property (strong,nonatomic) NSMutableArray *arrayAuthorGot;


@property (strong,nonatomic) NSString *thumbailGot;
@property(strong,nonatomic) NSMutableArray *arrayChapterGot;
@property(strong,nonatomic) NSMutableArray *arrayChapterName;
@property(strong,nonatomic) NSMutableArray *arrayChapterURL;
@property(strong,nonatomic) NSMutableArray *arrayChapterID;
@property(strong,nonatomic) NSMutableArray *arrayChapterIDContent;
@property(strong,nonatomic) NSMutableArray *arrayImageURL;

@property(strong,nonatomic) NSMutableArray *arrayImageForChapterToCheck;
@property(strong,nonatomic) NSMutableArray *arrayImageForChapterToDelete;
@property(strong,nonatomic) NSMutableArray *chapterIDFavorite;

@property (strong,nonatomic) NSString *currentChapterID;
@property (strong,nonatomic) NSString *currentChapterIDToCheck;
@property (strong,nonatomic) NSString *currentChapterIDToDelete;

@property (strong,nonatomic) NSString *chapterNameAtIndex;

@property (strong,nonatomic) NSMutableArray *arrayListContent;

@property long int indexOfChapterName;

@end
