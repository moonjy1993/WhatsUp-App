
#import <UIKit/UIKit.h>

// will segue its imageURL to a URLViewController
// (and supports doing so in a popover if desired)

@interface ImageViewController : UIViewController

// Model for this MVC ... URL of an image to display
@property (nonatomic, strong) NSURL *imageURL;

@end
