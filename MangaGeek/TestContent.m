//
//  TestContent.m
//  MangaGeek
//
//  Created by NhatMinh on 7/10/15.
//  Copyright (c) 2015 NhatMinh. All rights reserved.
//

#import "TestContent.h"

@interface TestContent ()

@end

@implementation TestContent

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"======   %@",self.chapterIDGot);
    NSLog(@"+++++++   %@",self.chapterNameAtIndexGot);
    [self.navigationItem setTitle:self.chapterNameAtIndexGot];
    
    
  
    
   
   // self.currentIndexChapter=(int)[self.arrayChapterIDContentGot indexOfObject:@"NAR697"];
    
    //[self.arrayImageURLGot objectAtIndex:[self.arrayChapterIDContentGot indexOfObject:@"NAR697"]];

   // NSLog(@"************** %@",[self.arrayImageURLGot objectAtIndex:[self.arrayChapterIDContentGot indexOfObject:self.chapterIDGot]]);
    
    self.arrayImageForChapter=[self.arrayImageURLGot objectAtIndex:[self.arrayChapterIDContentGot indexOfObject:self.chapterIDGot]];
    
    // *******************   PageView *******************************
    self.pageViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource=self;
    PageViewContentChapter *startingViewController= [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
   [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageViewContentChapter*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageViewContentChapter*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.arrayImageForChapter count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (PageViewContentChapter*)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.arrayImageForChapter count] == 0) || (index >= [self.arrayImageForChapter count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageViewContentChapter *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
   pageContentViewController.urlImage = [NSURL URLWithString:(NSString*)[self.arrayImageForChapter objectAtIndex:index]];
    
    //pageContentViewController.urlImage = [self.arrayImageForChapter objectAtIndex:index];
    // pageContentViewController.urlImage =[self.arrayImageForChapter objectAtIndex:index];
    
   // pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.arrayImageForChapterGot=self.arrayImageForChapter;
    pageContentViewController.chapterIDGot=self.chapterIDGot;
    pageContentViewController.chapterNameAtIndexGot=self.chapterNameAtIndexGot;
    
    return pageContentViewController;
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.arrayImageForChapter count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


- (IBAction)btnGoToPage:(id)sender {
    
    unsigned long gotoIndex = (unsigned long)[[self.txtFGoToPage text] integerValue];
    if (gotoIndex>=self.arrayImageForChapter.count) {
        gotoIndex=self.arrayImageForChapter.count-1;
       
 
    }
    else {
        gotoIndex=gotoIndex;
    }
    PageViewContentChapter *startingViewController = [self viewControllerAtIndex:gotoIndex];
   // PageViewContentChapter *startingViewController = [self viewControllerAtIndex:gotoIndex];
    //NSArray *viewControllers = @[startingViewController];
    NSArray *viewControllers=[NSArray arrayWithObject:startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    
}
@end


