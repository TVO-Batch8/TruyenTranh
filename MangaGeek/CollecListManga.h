//
//  CollecListManga.h
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ImageCollectionViewCell.h"
#import "ListChapter.h"

@interface CollecListManga : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (strong,nonatomic) NSArray *arrayImageManga;
@property (strong,nonatomic) NSMutableArray *arrayThumbail;
@property (strong,nonatomic) NSMutableArray *arrayMangaName;
@property (strong,nonatomic) NSMutableArray *arrayAuthor;
@property (strong,nonatomic) NSMutableArray *arrayMangaID;
@property (strong,nonatomic) NSMutableArray *arrayDesc;

@property (strong,nonatomic) NSMutableArray *arrayChapter;

@property (strong,nonatomic) NSMutableArray *arrayListManga;

@property  int *index;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionManga;


@end
