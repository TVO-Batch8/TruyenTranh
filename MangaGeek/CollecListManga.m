//
//  CollecListManga.m
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "CollecListManga.h"

@interface CollecListManga ()

@end

@implementation CollecListManga

static NSString * const CellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionManga registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.collectionManga.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background1.png"]];
    
    self.arrayImageManga=[NSArray arrayWithObjects:@"NarutoShippuden.jpg",@"OnePiece.jpg",@"Bleach.jpeg",@"Doreamon.jpg",@"DragonBall.jpg",@"Gintama.jpg",@"InuYasha.jpg",@"Pokemon.jpg",@"UQHolder.png",@"Subasa.jpg",@"Oresama.jpg",@"Conan.jpg",nil];
    
   
    
    [self parseJSONFile];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MANGA"];
    self.arrayListManga = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //NSManagedObject *arrayMangaFetch = [self.arrayListManga valueForKey:@"mangaName"];
    self.arrayMangaName=[NSMutableArray arrayWithObject:[self.arrayListManga valueForKey:@"mangaName"]];
    self.arrayAuthor=[NSMutableArray arrayWithObject:[self.arrayListManga valueForKey:@"author"]];
    self.arrayDesc=[NSMutableArray arrayWithObject:[self.arrayListManga valueForKey:@"desc"]];
    self.arrayThumbail=[NSMutableArray arrayWithObject:[self.arrayListManga valueForKey:@"mangaID"]];
    self.arrayMangaID=[NSMutableArray arrayWithObject:[self.arrayListManga valueForKey:@"thumbail"]];
    
}

-(void)parseJSONFile
{
    
    //StoryBookData
    self.arrayThumbail=[[NSMutableArray alloc]init];
    self.arrayMangaName=[[NSMutableArray alloc]init];
    self.arrayAuthor=[[NSMutableArray alloc]init];
    self.arrayMangaID=[[NSMutableArray alloc]init];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MANGA" ofType:@"json"]];
    
    NSDictionary *dicTemp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *arrayManga =[dicTemp valueForKey:@"manga"];
    for (int i=0; i<arrayManga.count; i++) {
        [self.arrayThumbail addObject:[[arrayManga objectAtIndex:i] valueForKey:@"thumbail"]];
        [self.arrayMangaName addObject:[[arrayManga objectAtIndex:i] valueForKey:@"mangaName"]];
        [self.arrayAuthor addObject:[[arrayManga objectAtIndex:i] valueForKey:@"author"]];
        [self.arrayMangaID addObject:[[arrayManga objectAtIndex:i] valueForKey:@"mangaID"]];
    }
    
    NSData *dataChapter = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CHAPTER" ofType:@"json"]];
     NSDictionary *dicChapter = [NSJSONSerialization JSONObjectWithData:dataChapter options:0 error:nil];
    self.arrayChapter=[dicChapter valueForKey:@"chapter"];


}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

   
    return self.arrayImageManga.count;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   
    //ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgCVCcell" forIndexPath:indexPath];
    
    
    cell.imgCVCcell.image=[UIImage imageNamed:[self.arrayThumbail objectAtIndex:indexPath.row]];
    [cell loadTitle:[NSString stringWithFormat:@""]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.index=(NSInteger*)indexPath.item;
    NSLog(@"da chon %ld",(long)indexPath.item);
    NSLog(@"%@-----%@",[self.arrayThumbail objectAtIndex:indexPath.item],[self.arrayMangaID objectAtIndex:indexPath.item]);
    
    NSLog(@"&&&&&&&  %@",[[self.arrayChapter objectAtIndex:self.index] valueForKey:@"mangaID"]);
    
    if ([[self.arrayMangaID objectAtIndex:indexPath.item] isEqualToString:[[self.arrayChapter objectAtIndex:indexPath.item] valueForKey:@"mangaID"]]) {
        [self performSegueWithIdentifier:@"ShowListChapter" sender:nil];
    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowListChapter"]) {
        //[self.collectionManga indexPathForCell:<#(UICollectionViewCell *)#>]
        NSLog(@"**********  %ld",self.index);
        
        NSLog(@"%@",[self.arrayMangaID objectAtIndex:self.index]);
        ListChapter *listChapter= segue.destinationViewController;
        
        listChapter.thumbailGot=[self.arrayThumbail objectAtIndex:self.index];
        
        listChapter.arrayChapterGot=[self.arrayChapter objectAtIndex:self.index];

        listChapter.arrayThumbailgot=self.arrayThumbail;
        listChapter.arrayMangaNameGot=self.arrayMangaName;
        listChapter.arrayAuthorGot=self.arrayAuthor;
        
       
        
    }
    
}

@end
