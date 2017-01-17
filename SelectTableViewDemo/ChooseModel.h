//
//  ChooseModel.h
//  SelectTableViewDemo
//
//  Created by WangQiao on 17/1/12.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic)         BOOL     isSelected;

+ (id)chooseModelWithTitle:(NSString *)title isSelected:(BOOL)isSelected;

@end
