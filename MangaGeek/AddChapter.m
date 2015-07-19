//
//  AddChapter.m
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "AddChapter.h"

@interface AddChapter ()

@end

@implementation AddChapter

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseJSONFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)parseJSONFile
{
    
    //StoryBookData
    self.arrayChapterID=[[NSMutableArray alloc]init];
    self.arrayChaperName=[[NSMutableArray alloc]init];
    self.arrayChapterURL=[[NSMutableArray alloc]init];
    self.arrayMangaID=[[NSMutableArray alloc]init];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CHAPTER" ofType:@"json"]];
    
    NSDictionary *dicTemp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *arrayManga =[dicTemp valueForKey:@"chapter"];
    for (int i=0; i<arrayManga.count; i++) {
        [self.arrayChapterID addObject:[[arrayManga objectAtIndex:i] valueForKey:@"chapterID"]];
        [self.arrayChaperName addObject:[[arrayManga objectAtIndex:i] valueForKey:@"chapterName"]];
        [self.arrayChapterURL addObject:[[arrayManga objectAtIndex:i] valueForKey:@"chapterURL"]];
        [self.arrayMangaID addObject:[[arrayManga objectAtIndex:i] valueForKey:@"mangaID"]];
        
    }
    
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}




- (IBAction)Save:(id)sender {
    int i;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    
    
    for (i=0; i<self.arrayChaperName.count; i++) {
        NSManagedObject *newChapter = [NSEntityDescription insertNewObjectForEntityForName:@"CHAPTER" inManagedObjectContext:context];
        
        
        [newChapter setValue:[self.arrayChaperName objectAtIndex:i] forKey:@"chapterName"];
        [newChapter setValue:[self.arrayChapterID objectAtIndex:i] forKey:@"chapterID"];
        [newChapter setValue:[self.arrayChapterURL objectAtIndex:i] forKey:@"chapterURL"];
        [newChapter setValue:[self.arrayMangaID objectAtIndex:i] forKey:@"mangaID"];
        
        
        
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
