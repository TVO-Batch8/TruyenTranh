//
//  Favorite.h
//  MangaGeek
//
//  Created by NhatMinh on 7/17/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableCell.h"
#import "TestContent.h"
#import <CoreData/CoreData.h>

@interface Favorite : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableListFavorite;





@property long int index;



@property (strong,nonatomic) NSString *chapterNameAtIndex;
@property (strong,nonatomic) NSString *chapterIDAtIndex;


@property (strong,nonatomic) NSMutableArray *arrayChapterIDFavorite;
@property (strong,nonatomic) NSMutableArray *arrayImageFavorite;
@property (strong,nonatomic) NSMutableArray *arrayChapterNameFavorite;
@property (strong,nonatomic) NSMutableArray *arrayImageForChapterFavorite;


@property (strong,nonatomic) NSMutableArray *arrayFavorite;

@property long int indexOfChapterName;


@end
