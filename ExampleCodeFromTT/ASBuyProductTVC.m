//
//  ASBuyProductTVC.m
//  ExampleCodeFromTT
//
//  Created by MD on 19.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASBuyProductTVC.h"

// model
#import "ASProduct.h"

// custom cell
#import "ASBuyProductCell.h"

// view controllers
#import "ASDetailProductTVC.h"


@interface ASBuyProductTVC ()  <UITableViewDataSource,  UITableViewDelegate,  UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray* listProductArray;
@property (assign,nonatomic)  BOOL loadingDataWall;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation ASBuyProductTVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     NSMutableDictionary *dictplist =[[NSMutableDictionary alloc] initWithContentsOfFile:path];
     
     NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
     self.listProductArray = [NSMutableArray array];
     [self.listProductArray insertObjects:[dictplist objectForKey:@"dataArray"] atIndexes:indexSet];
     
    */
     self.loadingDataWall      = YES;
     self.firstTimeAppear      = YES;
 
     self.listProductArray = [NSMutableArray array];
  

    self.navigationController.navigationBar.barStyle     = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.333 green:0.584 blue:0.820 alpha:1.000];
    self.navigationController.navigationBar.tintColor    = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
    if (self.firstTimeAppear) {
        self.firstTimeAppear = NO;
        
        // загружаем по троечке
        [self parseDataFromPlistWithCount:6 onOffset:0];
    }
    
}


#pragma mark - Parse

-(void) parseDataFromPlistWithCount:(NSInteger) count onOffset:(NSInteger) offset {
    
    NSIndexSet *indexSet     = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(offset, count)];
    NSMutableArray* products = [NSMutableArray array];
    
    
    NSString            *path      = [[NSBundle mainBundle] pathForResource: @"dataList" ofType: @"plist"];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    //[products insertObjects:[dictplist objectForKey:@"dataArray"] atIndexes:indexSet];

  
    for (int i=[self.listProductArray count]; i<count; i++) {
        
        NSDictionary* dict = [[dictplist objectForKey:@"dataArray"] objectAtIndex:i];
        [products addObject:dict];
    }
    
    
    NSMutableArray* arrayWithProducts = [NSMutableArray array];

    if ([products count] > 0) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            
            NSMutableArray* arrPath = [NSMutableArray array];
            
            for (NSInteger i= [self.listProductArray count]; i<=[products count]+[self.listProductArray count]-1; i++) {
                
                [arrPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            
            
            for (int i=0; i<[products count]; i++) {
                
                NSDictionary* dictItem = products[i];
                ASProduct*    product  = [[ASProduct alloc] initWithDict:dictItem];
                
                [arrayWithProducts addObject:product];
            }
            
            
            
            [self.listProductArray addObjectsFromArray:arrayWithProducts];
            
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:arrPath withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
                
                
                self.loadingDataWall = NO;
                
            });
            
        });
        
    }

}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASProduct*  product  = self.listProductArray[indexPath.row];
    ASDetailProductTVC* detailVC = (ASDetailProductTVC*)[storyboard instantiateViewControllerWithIdentifier:@"ASDetailProductTVC"];
    
    detailVC.currentProduct = product;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listProductArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    /*
     @property (weak, nonatomic) IBOutlet UIImageView *imageProduct;
     @property (weak, nonatomic) IBOutlet UILabel *nameProductLabel;
     @property (weak, nonatomic) IBOutlet UILabel *priceProductLabel;

     
    */
    
    static NSString* identifierProductCell  = @"ASCustomProductCell";
    
    ASBuyProductCell* cell = (ASBuyProductCell*)[tableView dequeueReusableCellWithIdentifier:identifierProductCell];
    if (!cell) {
        cell = [[ASBuyProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierProductCell];
    }

    ASProduct* product = self.listProductArray[indexPath.row];
    
    cell.imageProduct.image     = [UIImage imageNamed:[product.productImagesArray firstObject]];
    cell.nameProductLabel.text  = product.productName;
    cell.priceProductLabel.text = [NSString stringWithFormat:@"%.2f $",product.productPrice];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
