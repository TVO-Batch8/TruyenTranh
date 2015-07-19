//
//  AddContent.h
//  MangaGeek
//
//  Created by NhatMinh on 7/9/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddContent : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (strong,nonatomic) NSMutableArray *arrayChapterID;
@property (strong,nonatomic) NSMutableArray *arrayImageURL;

- (IBAction)Save:(id)sender;

@end
