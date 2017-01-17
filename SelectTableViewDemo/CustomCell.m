//
//  CustomCell.m
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

- (void)selectedEvent {

}

+ (CGFloat)cellHeightWithData:(id)data {

    return 0;
}

- (void)setWeakReferenceWithCellDataAdapter:(CellDataAdapter *)dataAdapter
                                       data:(id)data
                                  indexPath:(NSIndexPath *)indexPath
                                  tableView:(UITableView *)tableView {

    _dataAdapter = dataAdapter;
    _data        = data;
    _indexPath   = indexPath;
    _tableView   = tableView;
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                                   type:(NSInteger)type {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier
                                                              data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                              data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithCellHeight:(CGFloat)height {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:nil cellHeight:height cellType:0];
}

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (self.tableView && self.dataAdapter) {
        
        if (animated) {
            
            self.dataAdapter.cellHeight = height;
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            
        } else {
        
            self.dataAdapter.cellHeight = height;
            [self.tableView reloadData];
        }
    }
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {

    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView {

    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

@end
