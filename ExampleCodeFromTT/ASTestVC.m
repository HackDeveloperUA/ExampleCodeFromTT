
//
//  ASTestVC.m
//  ExampleCodeFromTT
//
//  Created by MD on 20.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASTestVC.h"

@interface ASTestVC ()

@end

@implementation ASTestVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = [UIImage imageNamed:self.imageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
