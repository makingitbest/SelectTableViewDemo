//
//  ChooseItemViewController.h
//  SelectTableViewDemo
//
//  Created by WangQiao on 17/1/12.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseItemViewControllerDelegate <NSObject>

- (void)chooseItemViewController:(id)controller  chooseString:(NSString *)string;

@end

@interface ChooseItemViewController : UIViewController

@property (nonatomic, weak)   id        <ChooseItemViewControllerDelegate>  delegate;
@property (nonatomic)         BOOL      radioSelection; // 是否单选
@property (nonatomic, strong) NSString *contentString;  // 内容字符串(如: "新材料,硬件,医疗健康,移动互联网")
@property (nonatomic, strong) NSString *chooseString;   // 选中字符串(如: 单选 "新材料", 多选 "新材料,硬件")
@property (nonatomic, weak)   id        object;


@end
