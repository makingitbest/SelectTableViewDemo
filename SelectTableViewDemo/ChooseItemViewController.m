//
//  ChooseItemViewController.m
//  SelectTableViewDemo
//
//  Created by WangQiao on 17/1/12.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "ChooseItemViewController.h"
#import "UIView+SetRect.h"
#import "ChooseModel.h"
#import "ChooseModelCell.h"

@interface ChooseItemViewController ()<UITableViewDelegate, UITableViewDataSource> {

    NSMutableArray <ChooseModel *> *_array;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseItemViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _array = [NSMutableArray array];
    
    NSArray  *stringArray       = [self.contentString componentsSeparatedByString:@","];
    NSArray  *chooseStringArray = [self.chooseString componentsSeparatedByString:@"," ];
    
    [stringArray enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL haveTheSame = NO;
        
        for (int i = 0; i < chooseStringArray.count; i ++) {
            
            if ([obj isEqualToString:chooseStringArray[i]]) {
                
                haveTheSame = YES;
                break;
            }
        }
        
        if (haveTheSame == YES) {
            
            [_array addObject:[ChooseModel chooseModelWithTitle:obj isSelected:YES]];
        } else {
        
            [_array addObject:[ChooseModel chooseModelWithTitle:obj isSelected:NO]];
        }
    }];
    
    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.rowHeight      = 50.f; //给一个固定高度，复用时会导致线条丢失。
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ChooseModelCell class] forCellReuseIdentifier:@"ChooseModelCell"];
    
    UIButton *button       = [[UIButton alloc] initWithFrame:CGRectMake(15, Height - 60, Width - 30, 50)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)buttonEvent {

    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseItemViewController:chooseString:)]) {
        
        if (self.radioSelection == YES) {
            
            __block NSString *string = nil;
            [_array enumerateObjectsUsingBlock:^(ChooseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.isSelected) {
                    
                    string = obj.title;
                    * stop = YES;
                }
            }];
            
            string.length ? 0:(string = @"");
            [self.delegate chooseItemViewController:self chooseString:string];
            
        } else {
        
            NSMutableString *string = [NSMutableString string];
            [_array enumerateObjectsUsingBlock:^(ChooseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.isSelected) {
                    
                    [string appendFormat:@"%@,",obj.title];
                }
            }];
            
            if (string.length) {
                
                [self.delegate chooseItemViewController:self chooseString:[string substringWithRange:NSMakeRange(0, string.length - 1)]];
                
            } else {
            
             [self.delegate chooseItemViewController:self chooseString:@""];
                
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseModelCell"];
    cell.data  = _array[indexPath.row];
    [cell loadContent];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.radioSelection) {
        
        ChooseModel *model = _array[indexPath.row];
        
        [_array enumerateObjectsUsingBlock:^(ChooseModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model isEqual:obj]) {
                
                obj.isSelected = YES;
                
            } else {
                
                obj.isSelected = NO;
            }
            
            [self.tableView reloadData];
            
        }];
        
    } else {
        
        ChooseModelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ChooseModel *model    = cell.data;
        model.isSelected      = !model.isSelected;
        
        [cell loadContent];
    }
}

@end
