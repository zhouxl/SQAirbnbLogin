//
//  SQOptionView.h
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SQHEX(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])


@interface SQOptionItem : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithTitle:(NSString *)title color:(UIColor *)color;

@end

#pragma mark - SQOptionView
@interface SQOptionView : UIView

@property (nonatomic, copy) void(^clickItem)(NSInteger index);

- (void)addOptions:(NSArray <SQOptionItem *> *)options;

@end
