
#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *twitterPost;
@property (weak, nonatomic) IBOutlet UITextView *facebookPost;
@property (weak, nonatomic) IBOutlet UITextView *chooseToPost;
- (void) showAlertMessage: (NSString *) myPost;
- (void) textViewBgColor;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textViewBgColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) showAlertMessage: (NSString *) myPost{
    UIAlertController *alertMessage;
    alertMessage = [UIAlertController alertControllerWithTitle:@"Twitter Share" message:myPost preferredStyle:UIAlertControllerStyleAlert];
    [alertMessage addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertMessage animated:YES completion:nil];
}

- (IBAction)postToTwitter:(id)sender {
    
    if([self.twitterPost isFirstResponder]){
        [self.twitterPost resignFirstResponder];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if([self.twitterPost.text length] < 140){
            [twitterVC setInitialText:self.twitterPost.text];
        }
        else{
            NSString *shortText = [self.twitterPost.text substringToIndex:140];
            [twitterVC setInitialText:shortText];
        }
        
        [self presentViewController:twitterVC animated:YES completion:nil];
    }
    else{
        [self showAlertMessage:@"You are not sign in to twitter"];
    }
}
                                  
- (IBAction)postToFacebook:(id)sender {
    
    if([self.facebookPost isFirstResponder]){
        [self.facebookPost resignFirstResponder];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.facebookPost.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
    }
    else{
        [self showAlertMessage:@"You are not sign in to facebook"];
    }
}

- (IBAction)postDependOnChoices:(id)sender {
    UIActivityViewController *moreVC = [[UIActivityViewController alloc]initWithActivityItems:@[self.chooseToPost.text] applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}

- (IBAction)postToNothing:(id)sender {
    UIAlertController *closeAlertActionController = [UIAlertController alertControllerWithTitle:@"No Share" message:@"Nothing to post" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *closeAlertAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
    [closeAlertActionController addAction:closeAlertAction];
    [self presentViewController:closeAlertActionController animated:YES completion:nil];
}

- (void) textViewBgColor{
    self.twitterPost.layer.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:204.0/255.0 blue:1.0 alpha:1.0].CGColor;
    self.facebookPost.layer.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:160.0/255.0 blue:1.0 alpha:1.0].CGColor;
    self.chooseToPost.layer.backgroundColor = [UIColor colorWithRed:67.0/255.0 green:192.0/255.0 blue:147.0/255.0 alpha:1.0].CGColor;
    self.twitterPost.layer.cornerRadius = 10;
    self.facebookPost.layer.cornerRadius = 10;
    self.chooseToPost.layer.cornerRadius = 10;
}

@end
