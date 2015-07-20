//
//  Favorite.m
//  MangaGeek
//
//  Created by NhatMinh on 7/17/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "Favorite.h"

@interface Favorite ()

@end

@implementation Favorite
static NSString * const CellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableListFavorite registerNib:[UINib nibWithNibName:@"CustomTableCell" bundle:nil] forCellReuseIdentifier:CellID];

    
    
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
   
    
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] initWithEntityName:@"FAVORITE"];
    self.arrayFavorite=[[managedObjectContext executeFetchRequest:fetchRequest4 error:nil] mutableCopy];
    
    if (!self.arrayFavorite.count) {
        UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"FAVORITE" message:@"danh sach rong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
        [Saved show];
        return;
    }
    
    
    self.arrayChapterIDFavorite=[[NSMutableArray alloc]init];
    self.arrayChapterNameFavorite=[[NSMutableArray alloc]init];
    self.arrayImageFavorite=[[NSMutableArray alloc]init];
    
    for (int i=0; i<self.arrayFavorite.count; i++) {
        [self.arrayChapterIDFavorite addObject:[[self.arrayFavorite objectAtIndex:i] valueForKey:@"chapterID"]];
        [self.arrayChapterNameFavorite addObject:[[self.arrayFavorite objectAtIndex:i] valueForKey:@"chapterName"]];
        [self.arrayImageFavorite addObject:[[self.arrayFavorite objectAtIndex:i] valueForKey:@"imageURL"]];
    }

//    if (!self.arrayChapterNameFavorite.count) {
//        UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"FAVORITE" message:@"danh sach rong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
//        [Saved show];
//        return;
//    }

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
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
    
    if (self.arrayChapterNameFavorite.count==0) {
        //return self.arrayChapterNameFavorite.count;
        return 1;
    }
    else
    {
        return self.arrayChapterNameFavorite.count ;
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
    //[cell loadImage:[NSString stringWithFormat:@"%@",[self.arrayThumbail objectAtIndex:indexPath.row]]];
    if (self.arrayChapterNameFavorite.count==0) {
        [self.arrayChapterNameFavorite addObject:@" Danh sach rong"];
        
    }
    [cell loadTilte:[NSString stringWithFormat:@"%@",  [self.arrayChapterNameFavorite objectAtIndex:indexPath.row]  ]];
    [cell loadDate:[NSString stringWithFormat:@"Today"]];
    [cell hideButton];
    
    cell.accessoryType=UITableViewCellStyleValue1;
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background5.jpg"]]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.arrayFavorite objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.arrayChapterNameFavorite removeObjectAtIndex:indexPath.row];
        
        NSLog(@"");
        
       [self.arrayChapterIDFavorite removeObjectAtIndex:indexPath.row];
//       [self.tableListFavorite deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableListFavorite reloadData];
        if (self.arrayChapterNameFavorite.count==0) {
            [self.tableListFavorite setHidden:YES];
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.index=indexPath.item;
    
    self.chapterIDAtIndex=[self.arrayChapterIDFavorite objectAtIndex:indexPath.row];
    self.chapterNameAtIndex=[self.arrayChapterNameFavorite objectAtIndex:indexPath.row];
    NSLog(@"vi tri %ld. %@ ",(long)indexPath.item,self.chapterIDAtIndex);
    self.arrayImageForChapterFavorite=[self.arrayImageFavorite objectAtIndex:[self.arrayChapterIDFavorite indexOfObject:self.chapterIDAtIndex]];
    NSLog(@"=>> %ld",self.arrayImageForChapterFavorite.count);
    [self performSegueWithIdentifier:@"FavotiteToContent" sender:nil];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"FavotiteToContent"]) {
        //[self.collectionManga indexPathForCell:<#(UICollectionViewCell *)#>]
        
        TestContent *testContent= segue.destinationViewController;
        testContent.chapterIDGot=self.chapterIDAtIndex;
        
        testContent.arrayChapterIDContentGot=self.arrayChapterIDFavorite;
        testContent.arrayImageURLGot=self.arrayImageFavorite;
        
        testContent.chapterNameAtIndexGot=self.chapterNameAtIndex;
        
    }
    
}


@end
