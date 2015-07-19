//
//  CustomTableCell.h
//  RSSfun
//
//  Created by NhatMinh on 7/1/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgArticle;
@property (weak, nonatomic) IBOutlet UILabel *titleArticle;
@property (weak, nonatomic) IBOutlet UILabel *dateArticle;

@property (weak, nonatomic) IBOutlet UILabel *labelClear;



-(void)loadTilte:(NSString*)Title;
-(void)loadDate:(NSString*)Date;
-(void)loadImage:(NSString *)imgName;
-(void)hideButton;
@end
