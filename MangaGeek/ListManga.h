//
//  ListManga.h
//  MangaGeek
//
//  Created by NhatMinh on 7/7/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ListChapter.h"
#import "CustomTableCell.h"

@interface ListManga : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableListManga;

@property (strong,nonatomic) NSMutableArray *arrayListManga;
@property (strong,nonatomic) NSMutableArray *arrayChapter;

@property (strong,nonatomic) NSMutableArray *arrayThumbail;
@property (strong,nonatomic) NSMutableArray *arrayMangaName;
@property (strong,nonatomic) NSMutableArray *arrayAuthor;
@property (strong,nonatomic) NSMutableArray *arrayMangaID;
@property (strong,nonatomic) NSMutableArray *arrayDesc;


@property long int index;

@end
