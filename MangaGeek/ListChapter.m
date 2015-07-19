//
//  ListChapter.m
//  MangaGeek
//
//  Created by NhatMinh on 7/10/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "ListChapter.h"

@interface ListChapter ()

@end

@implementation ListChapter
static NSString * const CellID = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableListChapter registerNib:[UINib nibWithNibName:@"CustomTableCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    //self.tableListChapter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background1.png"]];
    NSLog(@"%@",self.thumbailGot);
    self.arrayChapterName=[self.arrayChapterGot valueForKey:@"chapterName"];
    self.arrayChapterURL=[self.arrayChapterGot valueForKey:@"chapterURL"];
    self.arrayChapterID=[self.arrayChapterGot valueForKey:@"chapterID"];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CONTENT"];
    self.arrayListContent = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    self.arrayChapterIDContent=[[NSMutableArray alloc]init];
    self.arrayImageURL=[[NSMutableArray alloc]init];
    
    for (int i=0; i<self.arrayListContent.count; i++) {
        [self.arrayChapterIDContent addObject:[[self.arrayListContent objectAtIndex:i] valueForKey:@"chapterID"]];
        [self.arrayImageURL addObject:[[self.arrayListContent objectAtIndex:i] valueForKey:@"imageURL"]];
            }
    
    
    //[self parseJSONFile];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"FAVORITE"];
    self.chapterIDFavorite = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableListChapter reloadData];
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




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    if (self.arrayChapterName.count>0) {
        return self.arrayChapterName.count;
    }
    else
    {
        return 10;
    }
    //return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
        if (!cell) {
            cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
            //NSDictionary = @{@"key1": @"value 1", @"key 2":@"value 2"};
        }
    
    
    [cell loadImage:[NSString stringWithFormat:@"%@",self.thumbailGot]];
    [cell loadTilte:[NSString stringWithFormat:@"%@",[self.arrayChapterName objectAtIndex:indexPath.row]]];
    [cell loadDate:[NSString stringWithFormat:@""]];
    
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background5.jpg"]]];
    
    self.currentChapterIDToCheck=[self.arrayChapterID objectAtIndex:indexPath.row];
    self.arrayImageForChapterToCheck=[self.arrayImageURL objectAtIndex:[self.arrayChapterIDContent indexOfObject:self.currentChapterIDToCheck]];
    NSURL *urlToCheck=[NSURL URLWithString:[self.arrayImageForChapterToCheck objectAtIndex:0]];
    if ([[CacheImage sharedCacheImage] checkImageOndisk:urlToCheck]==NO) {
        [cell hideButton];
    }
    
   
    
    
    //cell.accessoryType=UITableViewCellStyleValue1;
    return cell;
}//***** End of cellForRowAtIndexPath ***********



///////////////////////////
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int i;
    
    //NSLog(@"\a\a\a\a\a\a\a\a\a ======>>> CLEAR MEN %ld",(long)indexPath.row);
    self.currentChapterIDToDelete=[self.arrayChapterID objectAtIndex:indexPath.row];
    self.arrayImageForChapterToDelete=[self.arrayImageURL objectAtIndex:[self.arrayChapterIDContent indexOfObject:self.currentChapterIDToDelete]];
    
   // NSLog(@"=>>>>>>  %@",self.arrayImageForChapterToDelete);
    
    for (i=0; i<self.arrayImageForChapterToDelete.count;i++) {
        //NSLog(@"phan tu tu %d : %@",i,[self.arrayImageForChapterToDelete objectAtIndex:i]);
        NSURL *urlToCheck=[NSURL URLWithString:[self.arrayImageForChapterToDelete objectAtIndex:0]];
        if ([[CacheImage sharedCacheImage] checkImageOndisk:urlToCheck]==YES) {
            [[CacheImage sharedCacheImage] deleteFileOnDiskWithURL:urlToCheck];
            
            //NSLog(@"********** Delete successed ***********");
        }
        else{
            NSLog(@"********** chua save lay gi delete  ***********");
        }
    }
    
    //=========== DELTE chapterID in Core Data ====================//
///    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete object from database
//        [context deleteObject:[self.arrayChapterID objectAtIndex:indexPath.row]];
//        
//        NSError *error = nil;
//        if (![context save:&error]) {
//            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
//            return;
//        }
    
        // Remove device from table view
//        if(self.feed.count>=1){
//            [self.feed removeObjectAtIndex:indexPath.row];
//            [self.feedTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
//        else{
//            
//            UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"Luu Offline " message:@"Danh sach rong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
//            [Saved show];
//            return;
//        }
//    }


    
    //[[CacheImage sharedCacheImage] clearAllCache];
}
//////////////////////////////





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.row);
    
    //NSLog(@"^^^^  %@",[self.arrayChapterID objectAtIndex:indexPath.row]);
    self.currentChapterID=[self.arrayChapterID objectAtIndex:indexPath.row];
    
    NSLog(@"^^ %@",self.currentChapterID);
    
    //[self.arrayChapterIDContent objectAtIndex:currentChapterID];
   
    
//    for (int i=0; i<self.arrayChapterIDContent.count; i++) {
//         //NSLog(@"!!!!  %@",[self.arrayChapterIDContent objectAtIndex:@"NAR700"]);
//    }
    self.indexOfChapterName=indexPath.row;
    
    
    
     [self performSegueWithIdentifier:@"ShowContent" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowContent"]) {
        //[self.collectionManga indexPathForCell:<#(UICollectionViewCell *)#>]
        
        TestContent *testContent= segue.destinationViewController;
        testContent.chapterIDGot=self.currentChapterID;
        
        testContent.arrayChapterIDContentGot=self.arrayChapterIDContent;
        testContent.arrayImageURLGot=self.arrayImageURL;
        
        testContent.chapterNameAtIndexGot=[self.arrayChapterName objectAtIndex:self.indexOfChapterName];
        
    }
    
}

@end























