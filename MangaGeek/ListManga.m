//
//  ListManga.m
//  MangaGeek
//
//  Created by NhatMinh on 7/7/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "ListManga.h"

@interface ListManga ()

@end

@implementation ListManga

static NSString * const CellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableListManga registerNib:[UINib nibWithNibName:@"CustomTableCell" bundle:nil] forCellReuseIdentifier:CellID];
    //[self.searchbarManga setHidden:YES];
    
    self.arrayThumbail=[[NSMutableArray alloc]init];
    self.arrayMangaName=[[NSMutableArray alloc]init];
    self.arrayAuthor=[[NSMutableArray alloc]init];
    self.arrayMangaID=[[NSMutableArray alloc]init];
    self.arrayDesc=[[NSMutableArray alloc]init];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MANGA"];
    self.arrayListManga = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"CHAPTER"];
    self.arrayChapter = [[managedObjectContext executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    
    for (int i=0; i<self.arrayListManga.count; i++) {
        [self.arrayThumbail addObject:[[self.arrayListManga objectAtIndex:i] valueForKey:@"thumbail"]];
        [self.arrayMangaName addObject:[[self.arrayListManga objectAtIndex:i] valueForKey:@"mangaName"]];
        [self.arrayAuthor addObject:[[self.arrayListManga objectAtIndex:i] valueForKey:@"author"]];
        [self.arrayMangaID addObject:[[self.arrayListManga objectAtIndex:i] valueForKey:@"mangaID"]];
        [self.arrayDesc addObject:[[self.arrayListManga objectAtIndex:i] valueForKey:@"desc"]];
    }


    
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
    
    [self.tableListManga reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    if (self.self.arrayMangaName.count>0) {
        return self.self.arrayMangaName.count;
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
    [cell loadImage:[NSString stringWithFormat:@"%@",[self.arrayThumbail objectAtIndex:indexPath.row]]];
    
    [cell loadTilte:[NSString stringWithFormat:@"%@",  [self.self.arrayMangaName objectAtIndex:indexPath.row]  ]];
    [cell loadDate:[NSString stringWithFormat:@"%@ ",[self.arrayDesc objectAtIndex:indexPath.row]]];
    [cell hideButton];
    
    cell.accessoryType=UITableViewCellStyleValue1;
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background5.jpg"]]];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.index=indexPath.item;
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

bool isSearch=NO;
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    isSearch=YES;
//    NSMutableArray *arraySearch=[[NSMutableArray alloc]init];
//    
//    for(int i=0;i<self.arrayMangaName.count;i++){
//        if ([[self.arrayMangaName objectAtIndex:i] isEqualToString:self.searchbarManga.text]) {
//            
//            NSLog(@" tim thay ");
//            [arraySearch addObject:[self.arrayMangaName objectAtIndex:i]];
//            
//            
//            
//            
//        }// if
//        
//        //[self.arrayMangaName removeAllObjects];
//        
//        
//    }
//    self.arrayMangaName = arraySearch;
//    
//    [self.tableListManga reloadData];
//}




@end
