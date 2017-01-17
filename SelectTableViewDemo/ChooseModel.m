//
//  ChooseModel.m
//  SelectTableViewDemo
//
//  Created by WangQiao on 17/1/12.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "ChooseModel.h"

@implementation ChooseModel

+ (id)chooseModelWithTitle:(NSString *)title isSelected:(BOOL)isSelected {

    ChooseModel *chooseModel = [[[self class] alloc] init];
    chooseModel.title        = title;
    chooseModel.isSelected   = isSelected;
    
    return chooseModel;
}

@end
