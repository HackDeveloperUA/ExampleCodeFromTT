//
//  ASTestVC.h
//  ExampleCodeFromTT
//
//  Created by MD on 20.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTestVC : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSString* imageName;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
