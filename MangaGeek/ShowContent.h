//
//  ShowContent.h
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ShowContent : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableListContent;
@property (strong,nonatomic) NSMutableArray *arrayListContent;
@end
