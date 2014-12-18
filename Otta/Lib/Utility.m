
#import "Utility.h"

@implementation Utility

+ (NSString *) timeAgo:(NSDate *)origDate{
    NSDate *timeNow = [[NSDate alloc] init];
    double ti = [timeNow timeIntervalSinceDate:origDate];
    ti = ti*-1;
    if (ti < 60) {
        return [NSString stringWithFormat:@"1 min"];
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        if (diff == 60) return [NSString stringWithFormat:@"1 hour"];
        return [NSString stringWithFormat:@"%d minutes", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        if (diff ==24) return [NSString stringWithFormat:@"1 day"];
        if (diff ==1) return [NSString stringWithFormat:@"1 hour"];
        return[NSString stringWithFormat:@"%d hours", diff];
    } else if (ti < 604800) {
        int diff = round(ti / 60 / 60 / 24);
        if (diff ==7) return [NSString stringWithFormat:@"1 week"];
        return[NSString stringWithFormat:@"%d days", diff];
    } else if (ti <= 2419200){
        int diff = ceil(ti / 60 / 60 / 24 / 7);
        if (diff ==1) return [NSString stringWithFormat:@"1 week"];
        return[NSString stringWithFormat:@"%d weeks", diff];
    } else if (ti > 2419200){
        int diff = ceil(ti / 60 / 60 / 24 / 30);
        if (diff ==1) return [NSString stringWithFormat:@"1 month"];
        return[NSString stringWithFormat:@"%d months", diff];
    }
    return @"";
}

+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
    return nil;
}
@end
