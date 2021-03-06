//
//  ShowChapter.m
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "ShowChapter.h"

@interface ShowChapter ()

@end

@implementation ShowChapter

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableListChapter registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CHAPTER"];
    self.arrayListChapter = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableListChapter reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (self.arrayListChapter) {
        return self.arrayListChapter.count;
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
    
    
    
    if (self.arrayListChapter.count!=0) {
        NSManagedObject *feed = [self.arrayListChapter objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%ld  --- %@ ",indexPath.row, [feed valueForKey:@"mangaID"]]];
        
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
        [context deleteObject:[self.arrayListChapter objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        if(self.arrayListChapter.count>=1){
            [self.arrayListChapter removeObjectAtIndex:indexPath.row];
            [self.tableListChapter deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else{
            
            UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"Luu Offline " message:@"Danh sach rong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
            [Saved show];
            return;
        }
    }
}


@end
