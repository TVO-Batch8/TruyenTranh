//
//  TestCoreData.m
//  MangaGeek
//
//  Created by NhatMinh on 7/8/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "TestCoreData.h"

@interface TestCoreData ()

@end

@implementation TestCoreData

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self parseJSONFile];
    }

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

-(void)parseJSONFile
{
    
    //StoryBookData
    self.arrayDesc=[[NSMutableArray alloc]init];
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
        [self.arrayDesc addObject:[[arrayManga objectAtIndex:i] valueForKey:@"description"]];
        
    }
    
    
}


- (IBAction)Save:(id)sender {
    int i;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    
    
    for (i=0; i<self.arrayMangaName.count; i++) {
        NSManagedObject *newManga = [NSEntityDescription insertNewObjectForEntityForName:@"MANGA" inManagedObjectContext:context];

        
        [newManga setValue:[self.arrayAuthor objectAtIndex:i] forKey:@"author"];
        [newManga setValue:[self.arrayDesc objectAtIndex:i] forKey:@"desc"];
        [newManga setValue:[self.arrayMangaID objectAtIndex:i] forKey:@"mangaID"];
        [newManga setValue:[self.arrayMangaName objectAtIndex:i] forKey:@"mangaName"];
        [newManga setValue:[self.arrayThumbail objectAtIndex:i] forKey:@"thumbail"];
        
        
        // Save the object to persistent store
            NSError *error = nil;
            if ([self.managedObjectContext save:&error])
            {
                NSLog(@"Successfully saved the context at position %d",i);
        
                //            UIAlertView *Saved =[[UIAlertView alloc]initWithTitle:@"Luu Offline " message:@"Da luu thanh cong" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
                //            [Saved show];
            }
            else
            {
                NSLog(@"Failed to save the context. Error = %@",error);
            }
        

        

        
    }//for
    

}
@end
