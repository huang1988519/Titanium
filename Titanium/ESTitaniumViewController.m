//
//  ESTitaniumViewController.m
//  Titanium
//
//  Created by Camille Kander on 5/29/14.
//  Copyright (c) 2014 Quri. All rights reserved.
//

#import "ESTitaniumViewController.h"
#import "ESImageViewController.h"

@interface ESTitaniumViewController () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *thumbnailViews;
@property (weak, nonatomic) IBOutlet UIImageView *extraThumbnail;
@property (strong, nonatomic) NSArray *images;

@property (strong, nonatomic) UIImageView *tappedThumbnail;

@end

static NSString * const kShowImageSegueIdentifier = @"ShowImage";

@implementation ESTitaniumViewController

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    NSArray *imageNames = @[@"frenchman.jpg", @"quri_card.jpg", @"quri_card.jpg"];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[imageNames count]];
    for (NSString *name in imageNames) {
        [images addObject:[UIImage imageNamed:name]];
    }
    self.images = [NSArray arrayWithArray:images];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.thumbnailViews enumerateObjectsUsingBlock:^(UIImageView *view, NSUInteger idx, BOOL *stop) {
        [view setImage:self.images[idx]];
        [view.layer setCornerRadius:25.0];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageView:)]];
    }];
    
    [self.extraThumbnail setImage:self.images[0]];
    [self.extraThumbnail.layer setCornerRadius:25.0];
    [self.extraThumbnail addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFrenchman)]];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Navigation

- (void)showImageView:(id)sender {
    
    [self performSegueWithIdentifier:@"ShowImage" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kShowImageSegueIdentifier]) {
        ESImageViewController *destination = segue.destinationViewController;
        UIImageView *tappedThumbnail = (UIImageView *)[(UITapGestureRecognizer *)sender view];
        [destination setTappedThumbnail:tappedThumbnail];
        [destination setImage:tappedThumbnail.image];
    }
}

#pragma mark - Old school nav

- (void)showFrenchman {
    ESImageViewController *ivc = [[ESImageViewController alloc] init];
    ivc.closeButton.hidden = NO;
    [ivc setTappedThumbnail:self.extraThumbnail];
    [ivc setImage:self.extraThumbnail.image];
    [self presentViewController:ivc animated:YES completion:nil];
}

#pragma mark - Unwind segues

- (IBAction)hideImage:(UIStoryboardSegue *)segue {

}

@end
