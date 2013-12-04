//
//  BroswerViewController.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-4.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "BroswerViewController.h"

@interface BroswerViewController ()

@end

@implementation BroswerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.urlStr = url;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"web view", @"网页浏览")];

    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"back", @"返回") style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [self.navigationItem setLeftBarButtonItem:item];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}
-(void)back:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
