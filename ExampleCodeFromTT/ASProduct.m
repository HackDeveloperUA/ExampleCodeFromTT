//
//  ASProduct.m
//  ExampleCodeFromTT
//
//  Created by MD on 19.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASProduct.h"

@implementation ASProduct


- (instancetype)initWithDict:(NSDictionary*) dict
{
    self = [super init];
    if (self) {
        
        
        self.productName        = [dict objectForKey:@"productName"];
        self.productDescription = [dict objectForKey:@"productDescription"];
        
        self.productImagesArray = [NSArray arrayWithArray:[dict objectForKey:@"productImageName"]];
        
        self.productPrice = [[dict objectForKey:@"productPrice"] doubleValue];
  
        
    }
    return self;
}



@end
