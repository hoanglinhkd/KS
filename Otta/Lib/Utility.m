
#import "Utility.h"

@implementation Utility

+ (NSString *) timeAgo:(NSDate *)origDate{
    NSDate *timeNow = [[NSDate alloc] init];
    double ti = [timeNow timeIntervalSinceDate:origDate];
    ti = ti*-1;
    if (ti < 60) {
        return [NSString stringWithFormat:@"%d sec",(int) ti];
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%d min", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%d hour", diff];
    } else if (ti < 2629743) {
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%d day", diff];
    }
    return @"";
}

+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
    return nil;
}
@end
