//
//  TestCoreData.h
//  MangaGeek
//
//  Created by NhatMinh on 7/8/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TestCoreData : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UITextField *textField5;


@property (strong,nonatomic) NSMutableArray *arrayDesc;
@property (strong,nonatomic) NSMutableArray *arrayThumbail;
@property (strong,nonatomic) NSMutableArray *arrayMangaName;
@property (strong,nonatomic) NSMutableArray *arrayAuthor;
@property (strong,nonatomic) NSMutableArray *arrayMangaID;

@property (strong,nonatomic) NSMutableArray *arrayChapter;


- (IBAction)Save:(id)sender;

@end
