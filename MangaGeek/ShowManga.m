//
//  ShowManga.m
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "ShowManga.h"

@interface ShowManga ()
@property (strong) NSMutableArray *arrayListManga;
@end

@implementation ShowManga
static NSString * const CellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableListManga registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
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
    
    [self.tableListManga reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (self.arrayListManga) {
        return self.arrayListManga.count;
    }
    else
    {
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    // Configure the cell...
    
    if (self.arrayListManga.count!=0) {
        NSManagedObject *feed = [self.arrayListManga objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%ld  --- %@ ",indexPath.row, [feed valueForKey:@"mangaName"]]];
        
        return cell;
    }
    else{
        [cell.textLabel setText:@"null"];
         return cell ;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.arrayListManga objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        if(self.arrayListManga.count>=1){
            [self.arrayListManga removeObjectAtIndex:indexPath.row];
            [self.tableListManga deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else{
            
            UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"Luu Offline " message:@"Danh sach rong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
            [Saved show];
            return;
        }
    }
}

@end








