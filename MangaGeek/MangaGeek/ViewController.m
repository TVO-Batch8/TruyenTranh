//
//  ViewController.m
//  MangaGeek
//
//  Created by NhatMinh on 7/7/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidload............");
    
     //[self parseJSONFile];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)parseJSONFile
//{
//    
//    //StoryBookData
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MangaData" ofType:@"json"]];
//    
//    NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    NSString *test=[dictTemp valueForKey:@"naruto"];
//    
//    NSDictionary *naru=[dictTemp valueForKey:@"naruto"];
//    NSArray *naru1=[dictTemp valueForKey:@"naruto"];
//    
//    NSArray *arrColors = [dictTemp valueForKey:@"chap_name"];
//    
//    
//   }

@end
