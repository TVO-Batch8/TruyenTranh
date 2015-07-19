//
//  ShowChapter.h
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ShowChapter : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableListChapter;

@property (strong,nonatomic) NSMutableArray *arrayListChapter;

@end
