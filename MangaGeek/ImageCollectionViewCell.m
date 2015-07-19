//
//  ImageCollectionViewCell.m
//  PhotoApp
//
//  Created by NhatMinh on 6/16/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)loadTitle:(NSString *)Tilte{
    self.imgTilte.text=Tilte;
}

@end
