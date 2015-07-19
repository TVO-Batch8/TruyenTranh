//
//  TestContent.h
//  MangaGeek
//
//  Created by NhatMinh on 7/10/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewContentChapter.h"


@interface TestContent : UIViewController <UIPageViewControllerDataSource>

@property(strong,nonatomic) NSString *chapterIDGot;
@property(strong,nonatomic) NSMutableArray *arrayChapterIDContentGot;
@property(strong,nonatomic) NSMutableArray *arrayImageURLGot;

@property(strong,nonatomic) NSMutableArray *arrayImageForChapter;

@property (strong,nonatomic) NSMutableArray *arrayTest;

//@property  NSUInteger *indexOfCurrentURL;

@property (strong,nonatomic) NSString *chapterNameAtIndexGot;

@property (strong, nonatomic) UIPageViewController *pageViewController;


@property (weak, nonatomic) IBOutlet UITextField *txtFGoToPage;

- (IBAction)btnGoToPage:(id)sender;

@end
