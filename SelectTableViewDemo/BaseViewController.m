//
//  BaseViewController.m
//  SelectTableViewDemo
//
//  Created by WangQiao on 17/1/11.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+SetRect.h"
#import "ChooseItemViewController.h"

typedef enum : NSUInteger {
    
    kCountryField = 1,
    kCountryButton,
    
    kPositionField,
    kPositionButton,
    

} EBaseViewController;

@interface BaseViewController () <UITextFieldDelegate, ChooseItemViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

// 选择城市
@property (nonatomic, strong) UIView      *selectCountryView;
@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UITextField *field;

// 选择
@property (nonatomic, strong) UIView      *selectPositionView;
@property (nonatomic, strong) UILabel     *positionLabel;
@property (nonatomic, strong) UIImageView *positionImageview;
@property (nonatomic, strong) UITextField *positionField;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    {
        self.selectCountryView = [[UIView alloc] initWithFrame:CGRectMake(0, 80 *0, Width, 40 + 40)];
        [self.scrollView addSubview:self.selectCountryView];
        
        {
            // 标签：所在城市
            self.label               = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 40)];
            self.label.font          = [UIFont systemFontOfSize:12];
            self.label.text          = @"实现多选";
            self.label.textAlignment = NSTextAlignmentLeft;
            [self.selectCountryView addSubview:self.label];
            
            //箭头
            self.imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_next"]];
            self.imageview.right        = Width - 15;
            self.imageview.centerY      = 60;
            self.imageview.hidden       = NO;
            [self.selectCountryView addSubview:self.imageview];
            
            // 文本框
            self.field           = [[UITextField alloc] initWithFrame:CGRectMake(15, 40, Width - 65, 40)];
            self.field.userInteractionEnabled = NO;
            self.field.placeholder  = @"可多选";
            self.field.font                   = [UIFont systemFontOfSize:12];
            self.field.tag                    = kCountryField;
            self.field.delegate               = self;
            [self.selectCountryView addSubview:self.field];
            
            // 点击事件
            UIButton *button = [[UIButton alloc] initWithFrame:self.selectCountryView.bounds];
            button.tag       = kCountryButton;
            [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.selectCountryView addSubview:button];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, Width, 0.5)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self.selectCountryView addSubview:lineView];
        }
    }
    
    {
        self.selectPositionView = [[UIView alloc] initWithFrame:CGRectMake(0, 80 *1, Width, 80)];
        [self.scrollView addSubview:self.selectPositionView];
        
        {
            self.positionLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 40)];
            self.positionLabel.font = [UIFont systemFontOfSize:12];
            self.positionLabel.text = @"实现单选";
            self.positionLabel.textAlignment = NSTextAlignmentLeft;
            [self.selectPositionView addSubview:self.positionLabel];
        
            //箭头
            self.positionImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_next"]];
            self.positionImageview.right        = Width - 15;
            self.positionImageview.centerY      = 60;
            self.positionImageview.hidden       = NO;
            [self.selectPositionView addSubview:self.positionImageview];
            
            
            // 文本框
            self.positionField                        = [[UITextField alloc] initWithFrame:CGRectMake(15, 40, Width - 65, 40)];
            self.positionField.userInteractionEnabled = NO;
            self.positionField.placeholder            = @"可单选";
            self.positionField.font                   = [UIFont systemFontOfSize:12];
            self.positionField.tag                    = kPositionField;
            self.positionField.delegate               = self;
            [self.selectPositionView addSubview:self.positionField];
            
            // 点击事件
            UIButton *button = [[UIButton alloc] initWithFrame:self.selectPositionView.bounds];
            button.tag       = kPositionButton;
            [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.selectPositionView addSubview:button];

            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, Width, 0.5)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self.selectPositionView addSubview:lineView];
        }
    
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)chooseItemViewController:(ChooseItemViewController *)controller chooseString:(NSString *)string {

    UITextField *field = controller.object;
    field.text         = string;
}

- (void)buttonEvent: (UIButton *) button {

    if (button.tag == kCountryButton) {
        
        ChooseItemViewController *controller = [[ChooseItemViewController alloc] init];
        controller.radioSelection = NO; // 单选yes  多选no
        controller.title          = @"选择";
        controller.contentString  = @"北京,上海,广州,沈阳,深圳,贵阳,郑州,武汉,长沙,南京";
        controller.chooseString   = self.field.text;
        controller.object         = self.field;
        controller.delegate       = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (button.tag == kPositionButton) {
        
        ChooseItemViewController *controller = [[ChooseItemViewController alloc] init];
        controller.radioSelection = YES; // 单选yes  多选no
        controller.title          = @"选择";
        controller.contentString  = @"技术,电工,教师,售后,客服,前台,开发";
        controller.chooseString   = self.positionField.text;
        controller.object         = self.positionField;
        controller.delegate       = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
