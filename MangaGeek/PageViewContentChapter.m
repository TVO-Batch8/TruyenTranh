//
//  PageViewContentChapter.m
//  MangaGeek
//
//  Created by NhatMinh on 7/11/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "PageViewContentChapter.h"
#import "UIImageView+WebCache.h"
#import "CacheImage.h"

@interface PageViewContentChapter ()
{
    BOOL isLoaded;
    NSURL *urlNext;
    NSURL *urlPrevious;
    unsigned long *indexOfCurrentURL;
    NSUInteger *totalPage;
    //NSUInteger *indexNext;
    NSUInteger *indexPre;
    
    UIPinchGestureRecognizer *twoFingerPinch;

    
}

@end
CGPoint firstTouchPoint;

//xd = destance between imge center and my touch center
float xd;
float yd;

@implementation PageViewContentChapter

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.labelCurrentPageIndex setText:[NSString stringWithFormat:@"%lu",(unsigned long)self.pageIndex]];
    [self.labelChapterName setText:self.chapterNameAtIndexGot];
    
    
    twoFingerPinch = [[UIPinchGestureRecognizer alloc]
                      initWithTarget:self
                      action:@selector(twoFingerPinch:)];
    [self.imgviewChapterContent addGestureRecognizer:twoFingerPinch];
    
    
//    self.chapterNameAtIndexGot =[[NSString alloc] init];
//    self.arrayImageForChapterGot=[[NSMutableArray alloc]init];
    
    //========================== Fetch data from FAVORITE =========================//
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] initWithEntityName:@"FAVORITE"];
    self.arrayFavorite=[[managedObjectContext executeFetchRequest:fetchRequest4 error:nil] mutableCopy];
    self.arrayChapterIDFavorite=[[NSMutableArray alloc]init];
    for (int i=0; i<self.arrayFavorite.count; i++) {
        [self.arrayChapterIDFavorite addObject:[[self.arrayFavorite objectAtIndex:i] valueForKey:@"chapterID"]];
    }
    
    NSLog(@"%@------------------------------------------------------------>>",self.chapterIDGot);
//    self.dataImage=[NSData dataWithContentsOfURL:self.urlImage];
//    self.image=[UIImage imageWithData:self.dataImage];
//    [self.imgviewChapterContent setImage:self.image];
    
    
//    [self.imgviewChapterContent sd_setImageWithURL:self.urlImage placeholderImage:[UIImage imageNamed:@"Loading.png"]];
    
//    NSString *decodeString= [self.urlImage stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    indexOfCurrentURL=(unsigned long)self.pageIndex;
    indexPre=(unsigned long)indexOfCurrentURL-1;
    self.indexNext=(unsigned long)indexOfCurrentURL+1;
    totalPage=self.arrayImageForChapterGot.count;
    
    if (indexOfCurrentURL==0) {
        indexPre=(unsigned long)indexOfCurrentURL;
    }
    if (self.indexNext==totalPage)
    {
         NSLog(@"**********************************Maxxxxxxxxxxxxxxx");
        self.indexNext=indexOfCurrentURL;
       
    }

    
    NSLog(@"------%lu--------%lu",(unsigned long)self.indexNext,(unsigned long)indexPre);
    NSLog(@">>>>>>>>>>>>>>>>>> %lu",(unsigned long)indexOfCurrentURL);

    //urlPrevious=[self.arrayImageForChapterGot objectAtIndex:indexPre];
    
    urlNext=[NSURL URLWithString:[self.arrayImageForChapterGot objectAtIndex:self.indexNext]];
    NSLog(@"******** URL NEXT ****** %@",urlNext);
   // NSLog(@"******** URL NEXT ****** %@",self.arrayImageForChapterGot);
    
    
    [[CacheImage sharedCacheImage] loadImageWithURL:urlNext completed:^(UIImage *image, NSError *error) {
        
        
     
    }];
  
    [[CacheImage sharedCacheImage] loadImageWithURL:self.urlImage completed:^(UIImage *image, NSError *error) {
        
        
        if (!error) {
            self.imgviewChapterContent.image = image;
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
    }];
    
    
    
}// method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}




//- (IBAction)btnClear:(id)sender {
////    NSLog(@"****** clear *****");
////    
////    [[CacheImage sharedCacheImage] clearAllCache];
////    
////    [[[UIAlertView alloc] initWithTitle:@"Done" message:@"Clear all cache." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//    
//    
//    [[CacheImage sharedCacheImage] checkImageOndisk:self.urlImage];
//    if ([[CacheImage sharedCacheImage] checkImageOndisk:self.urlImage]==YES) {
//        NSLog(@" co cai hinh nay trong cache hoac disk");
//    }
//    
//
//}

- (IBAction)btnSave:(id)sender {
    int i;
    for (i=0; i<=self.pageIndex; i++) {
        
        NSURL *urlToSave=[NSURL URLWithString:[self.arrayImageForChapterGot objectAtIndex:i]];
        NSLog(@"+++++++++ %d...urlTosave=>%@",i,urlToSave);
        [[CacheImage sharedCacheImage] saveOndisk:urlToSave];
    }
    //=============== save to data ===================
    for (int i=0;i<self.arrayChapterIDFavorite.count; i++) {
        if ([self.chapterIDGot isEqualToString:[self.arrayChapterIDFavorite objectAtIndex:i]]) {
            NSLog(@" ***************************************************************cai nay da luu roi");
            return;
        }
    }
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newChapterID = [NSEntityDescription insertNewObjectForEntityForName:@"FAVORITE" inManagedObjectContext:context];
    [newChapterID setValue:self.chapterIDGot forKey:@"chapterID"];
    [newChapterID setValue:self.chapterNameAtIndexGot forKey:@"chapterName"];
    [newChapterID setValue:self.arrayImageForChapterGot forKey:@"imageURL"];
    

    
    NSError *error = nil;
     //Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    if ([self.managedObjectContext save:&error])
    {
        NSLog(@"Successfully saved the context.");
        
        UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"Luu Offline " message:@"Da luu thanh cong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
        [Saved show];
    }
    else
    {
        NSLog(@"Failed to save the context. Error = %@",error);
    }

    
    //[[CacheImage sharedCacheImage] saveOndisk:[self.arrayImageForChapterGot objectAtIndex:0]];
}
//==================== TOUCH  EVENT ================
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    //    NSLog(@"Pinch scale: %f", recognizer.scale);
    if (recognizer.scale >1.0f && recognizer.scale < 2.5f) {
        CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
        self.imgviewChapterContent.transform = transform;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* mTouch = [touches anyObject];
    if (mTouch.view == [self imgviewChapterContent]) {
        CGPoint cp = [mTouch locationInView:[self view]];
        [[mTouch view]setCenter:CGPointMake(cp.x-xd, cp.y-yd)];
    }
}
@end


























