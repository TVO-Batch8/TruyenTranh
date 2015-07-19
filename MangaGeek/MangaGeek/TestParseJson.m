//
//  TestParseJson.m
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "TestParseJson.h"

@interface TestParseJson ()

@end

@implementation TestParseJson

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
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MANGA" ofType:@"json"]];
    
    NSDictionary *dicTemp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *arraymanga =[dicTemp valueForKey:@"manga"];
    NSDictionary *naruto=[arraymanga objectAtIndex:0];
    NSString *nar_author=[naruto valueForKey:@"author"];
    NSLog(@"%@",nar_author);
    
}

@end
