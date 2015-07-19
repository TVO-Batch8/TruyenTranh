//
//  ImageCollectionViewCell.h
//  PhotoApp
//
//  Created by NhatMinh on 6/16/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgCVCcell;

@property (weak, nonatomic) IBOutlet UILabel *imgTilte;

-(void)loadTitle:(NSString *)Tilte;

@end
