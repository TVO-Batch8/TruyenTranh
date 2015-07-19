//
//  CustomTableCell.m
//  RSSfun
//
//  Created by NhatMinh on 7/1/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadTilte:(NSString *)Title{
    self.titleArticle.text=Title;
}

-(void)loadDate:(NSString *)Date{
    self.dateArticle.text=Date;
    
   }

-(void)loadImage:(NSString *)imgName{
    //self.imgArticle.image=[UIImage imageNamed:imgName];
    [self.imgArticle setImage:[UIImage imageNamed:imgName]];
}
-(void)hideButton{
    
    [self.labelClear setHidden:YES];
}
@end
