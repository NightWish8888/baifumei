//
//  ArchiveImagePicker.m
//  baifumei
//
//  Created by 肖彦宇 on 13-12-30.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "ArchiveImagePicker.h"

@interface ArchiveImagePicker ()

@end

@implementation ArchiveImagePicker

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithData:(NSArray *)array Targate:(id<ArchiveImagePickerDelegate>) delegate{
    self= [super self];
    if (self) {
        self.dataSourceArray = array;
        _imagePickerDelegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.edgesForExtendedLayout =UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:item];

    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger count = self.dataSourceArray.count / 4;
    if (self.dataSourceArray.count %4 != 0) {
        count += 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *CellIdentifier = @"Cell";
    ArchiveImagePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (!cell) {
        cell = [[ArchiveImagePickerCell alloc] init];
    }
    [cell.btn1 setImage:nil forState:UIControlStateNormal];
    [cell.btn2 setImage:nil forState:UIControlStateNormal];
    [cell.btn3 setImage:nil forState:UIControlStateNormal];
    [cell.btn4 setImage:nil forState:UIControlStateNormal];
    [cell.btn1 setHidden:YES];
    [cell.btn2 setHidden:YES];
    [cell.btn3 setHidden:YES];
    [cell.btn4 setHidden:YES];
    for (int i = row * 4; i < (row + 1) * 4; i++) {
        if (i < self.dataSourceArray.count) {
//        NSString *path = [self.dataSourceArray objectAtIndex:i];
//        path = [kCacheRootPath stringByAppendingPathComponent:path];
//        UIImage *img = [UIImage imageWithContentsOfFile:path];
        NSData *data = [self.dataSourceArray objectAtIndex:i];
//        if (!data) {
//            NSLog(@"The row number is : %d,The i is: %d",row,i);
//        }
        UIImage *img = [UIImage imageWithData:data];
        switch (i % 4) {
            case 0:
            {
                [cell.btn1 setImage:img forState:UIControlStateNormal];
                cell.btn1.layer.borderWidth = 1.0f;
                cell.btn1.layer.borderColor = [[UIColor grayColor] CGColor];
                [cell.btn1 setHidden:NO];
                break;
            }
            case 1:{
                [cell.btn2 setImage:img forState:UIControlStateNormal];
                [cell.btn2 setHidden:NO];
                break;
            }
            case 2:{
                [cell.btn3 setImage:img forState:UIControlStateNormal];
                [cell.btn3 setHidden:NO];
                break;
            }
            case 3:{
                [cell.btn4 setImage:img forState:UIControlStateNormal];
                [cell.btn4 setHidden:NO];
                break;
            };
            default:
                break;
        }
        }
    }
    cell.selectImgDelegate = self;
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)cancel:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- ArchiveImgSelectDelegate
-(void)selectImg:(UIButton *)sender{
    //当前选择的照片
    if (_imagePickerDelegate && [_imagePickerDelegate respondsToSelector:@selector(selectImgInfo:)]) {
        [_imagePickerDelegate selectImgInfo:sender.imageView.image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
