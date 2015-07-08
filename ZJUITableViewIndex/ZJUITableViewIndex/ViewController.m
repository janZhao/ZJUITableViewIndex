//
//  ViewController.m
//  TestUITableviewIndex
//
//  Created by jyd on 15/7/8.
//  Copyright (c) 2015年 jyd. All rights reserved.
//

#import "ViewController.h"
#import "NameIndex.h"

@interface ViewController ()

@property NSMutableArray * dataSource, * dataBase;

/**
 *  自定义数据源
 */
@property (strong, nonatomic) NSMutableArray *friendsList;

@end

@implementation ViewController

-(NSMutableArray *)friendsList
{
    if (_friendsList == nil) {
        _friendsList = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _friendsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //这个是建立索引的核心
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
    
    //测试数据
    NSArray * nameArray = @[@"白飞",@"阿李",@"张三",@"李四",@"王五",@"andy",@"张冲",@"林峰",@"kylin",@"王磊",@"emily",@"陈标",@"billy",@"韦丽"];
    for (int i = 0; i<[nameArray count]; i++) {
        NameIndex *item = [[NameIndex alloc] init];
        item.lastName = [nameArray objectAtIndex:i];
        item.originIndex = i;
        [temp addObject:item];
    }
    
    //名字分section
    for (NameIndex *item in temp)
    {
        //getUserName(First Last Name)是实现中文拼音检索的核心，见NameIndex类
        NSInteger sect = [theCollation sectionForObject:item collationStringSelector:@selector(getLastName)];
        //设定姓的索引编号
        item.sectionNum = sect;
    }
    
    //返回27，是a－z和＃
    NSInteger highSection = [[theCollation sectionTitles] count];
    //tableView 会被分成27个section
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    //根据sectionNum把名字加入到对应section数组里
    for (NameIndex *item in temp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:item.sectionNum] addObject:item];
    }
    
    //进行排序后，加入到数据源中
    for (NSMutableArray *sectionArray in sectionArrays)
    {
         //按LastName firstName进行排序
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(getFirstName)];
        
        //这里friendsList是自己定义的列表数据源
        [self.friendsList addObject:sortedSection];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * existTitles = [NSMutableArray array];
    NSArray * allTitles = [[UILocalizedIndexedCollation currentCollation]sectionTitles];
    //section数组为空的title过滤掉，不显示
    for (int i=0; i<[allTitles count]; i++) {
        if ([[self.friendsList objectAtIndex:i] count] > 0) {
            [existTitles addObject:[allTitles objectAtIndex:i]];
        }
    }
    return existTitles;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.friendsList count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[self.friendsList objectAtIndex:section] count] > 0)
    {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.friendsList objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@",((NameIndex*)[[self.friendsList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).lastName]);
    
    //NSLog(@"%@", [NSString stringWithFormat:@"%@",((NameIndex*)[[self.friendsList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).firstName]);
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@%@",((NameIndex*)[[self.friendsList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).lastName,((NameIndex*)[[self.friendsList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).firstName];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",((NameIndex*)[[self.friendsList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).lastName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

@end
