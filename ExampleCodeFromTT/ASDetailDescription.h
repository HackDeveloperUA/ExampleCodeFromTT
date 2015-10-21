//
//  ASDetailDescription.h
//  ExampleCodeFromTT
//
//  Created by MD on 20.10.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDetailDescription : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


+ (CGFloat) heightForText:(NSString*) text wihtFontSize:(CGFloat) fontSize andWidthCell:(CGFloat) widthCell;
@end
