//
//  AddContent.m
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "AddContent.h"

@interface AddContent ()

@end

@implementation AddContent

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
    self.arrayImageURL=[[NSMutableArray alloc]init];

    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CONTENT" ofType:@"json"]];
    
    NSDictionary *dicTemp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *arrayManga =[dicTemp valueForKey:@"content"];
    for (int i=0; i<arrayManga.count; i++) {
        [self.arrayChapterID addObject:[[arrayManga objectAtIndex:i] valueForKey:@"chapterID"]];
        [self.arrayImageURL addObject:[[arrayManga objectAtIndex:i] valueForKey:@"imageURL"]];
        
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
    
    for (i=0; i<self.arrayChapterID.count; i++) {
        NSManagedObject *newContent = [NSEntityDescription insertNewObjectForEntityForName:@"CONTENT" inManagedObjectContext:context];
        
        
        [newContent setValue:[self.arrayImageURL objectAtIndex:i] forKey:@"imageURL"];
        [newContent setValue:[self.arrayChapterID objectAtIndex:i] forKey:@"chapterID"];
        
        
        
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
