//
//  SettingViewController.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-9.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    [self.navigationItem setRightBarButtonItem:item];
    [self.navigationItem setTitle:NSLocalizedString(@"set", @"设置")];
    NSArray *section1 = [NSArray arrayWithObject:NSLocalizedString(@"night mode", @"夜间模式")];
    NSArray *section2 = [NSArray arrayWithObject:NSLocalizedString(@"app ad", @"精品应用推荐")];
    NSArray *section3 = [NSArray arrayWithObject:NSLocalizedString(@"expansion application", @"把应用推荐给好友")];
    NSArray *section4 = [NSArray arrayWithObjects:NSLocalizedString(@"feedback", @"意见反馈"),NSLocalizedString(@"rate",@"给我评分"),NSLocalizedString(@"help",@"使用帮助"),NSLocalizedString(@"about",@"关于"), nil];
    self.summaryArray = [NSArray arrayWithObjects:section1,section2,section3,section4, nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.summaryArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.summaryArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.summaryArray objectAtIndex:section] objectAtIndex:row];
    switch (section) {
        case 0:{
            cell.imageView.image = [UIImage imageNamed:@"夜间模式.png"];
            UISwitch *seg = [[UISwitch alloc] init];
            [seg addTarget:self action:@selector(changeReadMode:) forControlEvents:UIControlEventValueChanged];
            
            
            BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:kReadMode];
            [seg setOn:state];
            [cell setAccessoryView:seg];
            break;
        }
        case 1:{
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //....显示❤️得图标
            break;
        }
        case 2:{
            
            break;
        }
        case 3:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        default:
            break;
    }
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 1:{
            [self appAD];
            break;
            
        }
        case 2:{
            [self expansionAPP];
            break;
        }
        case 3:{
            [self feedback];
            break;
        }
        case 4:{
            [self rate];
            break;
        }
        case 5:{
            [self help];
            break;
        }
        case 6:{
            [self about];
            break;
        }
            
        default:
            break;
    }
}

-(void)done:(UIBarButtonItem *)sender{
    //.........
    //............
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)changeReadMode:(UISwitch *)sender{
    
    [[NSUserDefaults standardUserDefaults] setBool:sender.on  forKey:kReadMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //............
    //.........
    
}
/**********精品应用推荐************/
-(void)appAD{
    
}
/*********把应用推荐给好友***********/
-(void)expansionAPP{
    
}
/*********意见反馈*************/
-(void)feedback{
    
}
/**********给我评分************/
-(void)rate{
    
}
/*******使用帮助***************/
-(void)help{
    
}

/**********关于************/
-(void)about{
    
}
@end
