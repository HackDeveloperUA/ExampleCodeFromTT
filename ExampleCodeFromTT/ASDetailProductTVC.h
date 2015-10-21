//
//  ASDetailProductTVC.h
//  ExampleCodeFromTT
//
//  Created by MD on 19.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASImagePageVC;
@class ASProduct;

@interface ASDetailProductTVC : UITableViewController

@property (strong, nonatomic) ASProduct* currentProduct;
@end
