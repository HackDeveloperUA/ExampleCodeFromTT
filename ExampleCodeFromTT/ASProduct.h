//
//  ASProduct.h
//  ExampleCodeFromTT
//
//  Created by MD on 19.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ASProduct : NSObject

@property (strong, nonatomic) NSString* productName;
@property (strong, nonatomic) NSString* productDescription;
@property (strong, nonatomic) NSArray*  productImagesArray;


@property (assign, nonatomic) double   productPrice;

- (instancetype)initWithDict:(NSDictionary*) dict;

@end
