//
//  AddChapter.h
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddChapter : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textFiled3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;

@property (strong,nonatomic) NSMutableArray *arrayChapterID;
@property (strong,nonatomic) NSMutableArray *arrayChaperName;
@property (strong,nonatomic) NSMutableArray *arrayChapterURL;
@property (strong,nonatomic) NSMutableArray *arrayMangaID;


- (IBAction)Save:(id)sender;

@end
