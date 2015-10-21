//
//  ASDetailProductTVC.m
//  ExampleCodeFromTT
//
//  Created by MD on 19.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASDetailProductTVC.h"
#import "ASTestVC.h"

// model
#import "ASProduct.h"


// custom cell
#import "ASDetailNameAndPrice.h"
#import "ASDetailDescription.h"
#import "ASDetailPageCell.h"


@interface ASDetailProductTVC () <UITabBarDelegate, UITableViewDataSource,UIScrollViewDelegate,UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
@end



@implementation ASDetailProductTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section==0) {
        return  0.f;
    }
    
    return 0.f;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([cell isKindOfClass:[ASDetailPageCell class]]) {
        return CGRectGetHeight(self.view.bounds)/2;
    }
    
    if ([cell isKindOfClass:[ASDetailNameAndPrice class]]) {
        return 90.f;
    }
    
    if ([cell isKindOfClass:[ASDetailDescription class]]) {
        return [ASDetailDescription heightForText:self.currentProduct.productDescription wihtFontSize:17.f andWidthCell:CGRectGetWidth(self.view.bounds)];
    }
    

    return 10.f;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}



/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(0  , 0, CGRectGetWidth(self.view.bounds),   CGRectGetHeight(self.view.bounds)/2)];
    //self.pageController.view.backgroundColor = [UIColor colorWithRed:0.03 green:0.29 blue:0.36 alpha:0.4];
    
    self.pageController.view.backgroundColor = [UIColor colorWithRed:0.333 green:0.584 blue:0.820 alpha:0.500];
    
    
    UIView* parentView = [[UIView alloc]initWithFrame:CGRectMake(0  , 0, CGRectGetWidth(self.view.bounds),  CGRectGetHeight(self.view.bounds)/2)];
    ASTestVC *initialViewController = [self viewControllerAtIndex:0];
    
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    
    // Внимание огонь !
    [parentView addSubview:[self.pageController view]];
    
    [self.pageController didMoveToParentViewController:self];
    
    return parentView;
}

*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    static NSString* identifierNamePriceCell    = @"ASDetailNameAndPrice";
    static NSString* identifierDescripptionCell = @"ASDetailDescription";
    static NSString* identifierPageCell         = @"ASDetailPageCell";


    
    
    if (indexPath.row == 0) {
        
       
         ASDetailPageCell*  cell = (ASDetailPageCell*)[tableView dequeueReusableCellWithIdentifier:identifierPageCell];
        
         if (!cell) {
            cell = [[ASDetailPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierPageCell];
         } else {
             if ([cell viewWithTag:111]) [[cell viewWithTag:111] removeFromSuperview];
             [cell.viewForPageVC addSubview:[self.pageController view]];
         }
        
        //if ([cell viewWithTag:111]) [[cell viewWithTag:111] removeFromSuperview];
       // [cell layoutIfNeeded];
        
        
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        self.pageController.dataSource = self;
        [[self.pageController view] setFrame:CGRectMake(0  , 0, CGRectGetWidth(self.view.bounds),   CGRectGetHeight(self.view.bounds)/2)];
        self.pageController.view.backgroundColor = [UIColor colorWithRed:0.333 green:0.584 blue:0.820 alpha:0.500];
        
        
        //UIView* parentView = [[UIView alloc]initWithFrame:CGRectMake(0  , 0, CGRectGetWidth(self.view.bounds),  CGRectGetHeight(self.view.bounds)/2)];
        cell.viewForPageVC.tag = 111;
        cell.viewForPageVC.frame = CGRectMake(0  , 0, CGRectGetWidth(self.view.bounds),  CGRectGetHeight(self.view.bounds)/2);
        ASTestVC *initialViewController = [self viewControllerAtIndex:0];
        
        
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:self.pageController];
        
        // Внимание огонь !
        //[cell.viewForPageVC addSubview:[self.pageController view]];
        
        [self.pageController didMoveToParentViewController:self];

        return cell;
    }
    

    
    if (indexPath.row == 1) {
        
        ASDetailNameAndPrice* cell = (ASDetailNameAndPrice*)[tableView dequeueReusableCellWithIdentifier:identifierNamePriceCell];
        if (!cell) {
            cell = [[ASDetailNameAndPrice alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierNamePriceCell];
        }
        
        cell.nameLabel.text  = self.currentProduct.productName;
        cell.priceLabel.text = [NSString stringWithFormat:@"%.0f $",self.currentProduct.productPrice];
        
        return cell;
   }
    
   
   if (indexPath.row == 2) {
 
       ASDetailDescription* cell = (ASDetailDescription*)[tableView dequeueReusableCellWithIdentifier:identifierDescripptionCell];
       if (!cell) {
           cell = [[ASDetailDescription alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierDescripptionCell];
       }
       
       cell.descriptionLabel.text = self.currentProduct.productDescription;
       
       return cell;

       
   }
 
    
    return nil;
}







#pragma mark - UIPageViewControllerDataSource


- (ASTestVC*)viewControllerAtIndex:(NSUInteger)index {
    
    ASTestVC *childViewController = (ASTestVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"ASTestVC"];
    childViewController.index     = index;
    childViewController.imageName = self.currentProduct.productImagesArray[index];
    
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
 
    NSUInteger index = [(ASTestVC *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    
    NSUInteger index = [(ASTestVC *)viewController index];
    index++;
    
    if (index == [self.currentProduct.productImagesArray count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.currentProduct.productImagesArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}









@end
