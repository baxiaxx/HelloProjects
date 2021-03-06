//
//  RootViewController.m
//  AppTest
//
//  Created by wesley chen on 15/6/26.
//
//

#import "RootViewController.h"

#import "GlobalConcurrentQueueViewController.h"
#import "CreateDispatchQueuesViewController.h"
#import "GetCommonQueuesViewController.h"
#import "SetSingleContextDataToQueueViewController.h"
#import "AddTaskToQueueViewController.h"
#import "AddCompletionBlockToQueueViewController.h"
#import "ConcurrentLoopViewController.h"
#import "SuspendAndResumeQueueViewController.h"
#import "UseDispatchSemaphoreViewController.h"
#import "UseDispatchGroupViewController.h"
#import "CreateQueueInactiveViewController.h"
#import "ExampleOfBatchDownloadImagesViewController.h"
#import "CreateTimerDispatchSourceViewController.h"
#import "CreateReadDispatchSourceViewController.h"
#import "CreateWriteDispatchSourceViewController.h"
#import "CreateVNodeDispatchSourceViewController.h"
#import "CreateDataBufferDispatchSourceViewController.h"
#import "UseDispatchBenchmarkViewController.h"
#import "UseDispatchIOViewController.h"
#import "DispatchOnceIssueCallStackViewController.h"

#define kTitle @"Title"
#define kClass @"Class"


@interface RootViewController ()
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *classes;
@end

@implementation RootViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self prepareForInit];
    }
    
    return self;
}

- (void)prepareForInit {
    self.title = @"AppTest";

    // MARK: Configure sectionTitles and classes for table view
    NSArray<NSDictionary *> *section1 = @[
          @{ kTitle: @"Get Global Concurrent Queues", kClass: @"GlobalConcurrentQueueViewController" },
          @{ kTitle: @"Create Serial Dispatch Queues", kClass: @"CreateDispatchQueuesViewController" },
          @{ kTitle: @"Get Common Queues", kClass: @"GetCommonQueuesViewController" },
          @{ kTitle: @"Set Single Context Data to Queues", kClass: @"SetSingleContextDataToQueueViewController" },
          @{ kTitle: @"Add Task to Queue", kClass: @"AddTaskToQueueViewController" },
          @{ kTitle: @"Add barrier Task to Concurrent Queue", kClass: @"AddBarrierTaskToConcurrentQueueViewController" },
          @{ kTitle: @"Add Completion Block to Queue", kClass: @"AddCompletionBlockToQueueViewController" },
          @{ kTitle: @"Use Concurrent Loop", kClass: @"ConcurrentLoopViewController" },
          @{ kTitle: @"Suspend & Resume Queue", kClass: @"SuspendAndResumeQueueViewController" },
          @{ kTitle: @"Use dispatch semaphore", kClass: @"UseDispatchSemaphoreViewController" },
          @{ kTitle: @"Use dispatch group", kClass: @"UseDispatchGroupViewController" },
          @{ kTitle: @"Create queue inactive", kClass: @"CreateQueueInactiveViewController" },
          @{ kTitle: @"Get Current Queue", kClass: @"GetCurrentQueueViewController" },
    ];
   
    /*
     #define DISPATCH_SOURCE_TYPE_DATA_ADD
     #define DISPATCH_SOURCE_TYPE_DATA_OR
     #define DISPATCH_SOURCE_TYPE_MACH_RECV
     #define DISPATCH_SOURCE_TYPE_MACH_SEND
     #define DISPATCH_SOURCE_TYPE_PROC
     #define DISPATCH_SOURCE_TYPE_READ
     #define DISPATCH_SOURCE_TYPE_SIGNAL
     #define DISPATCH_SOURCE_TYPE_TIMER
     #define DISPATCH_SOURCE_TYPE_VNODE
     #define DISPATCH_SOURCE_TYPE_WRITE
     */
    NSArray<NSDictionary *> *section2 = @[
          @{ kTitle: @"Create a Dispatch Source", kClass: @"CreateADispatchSourceViewController" },
          @{ kTitle: @"Create Timer Dispatch Source", kClass: @"CreateTimerDispatchSourceViewController" },
          @{ kTitle: @"Create Read Dispatch Source", kClass: @"CreateReadDispatchSourceViewController" },
          @{ kTitle: @"Create Write Dispatch Source", kClass: @"CreateWriteDispatchSourceViewController" },
          @{ kTitle: @"Create VNODE Dispatch Source", kClass: @"CreateVNodeDispatchSourceViewController" },
          @{ kTitle: @"Usage of Dispatch Data", kClass: @"CreateDataBufferDispatchSourceViewController" },
          @{ kTitle: @"Usage of Dispatch Benchmark", kClass: @"UseDispatchBenchmarkViewController" },
          @{ kTitle: @"Usage of Dispatch I/O (TODO)", kClass: @"UseDispatchIOViewController" },
    ];
    
    NSArray<NSDictionary *> *section3 = @[
          @{ kTitle: @"Example Of Batch Download Images", kClass: @"ExampleOfBatchDownloadImagesViewController" },
    ];
    
    NSArray<NSDictionary *> *section4 = @[
          @{ kTitle: @"Crash happen in dispatch_once", kClass: @"DispatchOnceIssueCallStackViewController" },
    ];
    
    _sectionTitles = @[
        @"dispatch queue",
        @"dispatch source",
        @"operation queue",
        @"GCD issues"
    ];
    
    _classes = @[
         section1,
         section2,
         section3,
         section4
    ];
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = _classes[indexPath.section][indexPath.row];
    [self pushViewController:dict];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitles[section];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_classes count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_classes[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *sCellIdentifier = @"RootViewController_sCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSString *cellTitle = [_classes[indexPath.section][indexPath.row] objectForKey:kTitle];
    cell.textLabel.text = cellTitle;

    return cell;
}

- (void)pushViewController:(NSDictionary *)dict {
    NSString *viewControllerClass = dict[kClass];
    NSAssert([viewControllerClass isKindOfClass:[NSString class]], @"%@ is not NSString", viewControllerClass);
    
    Class class = NSClassFromString(viewControllerClass);
    if (class && [class isSubclassOfClass:[UIViewController class]]) {
        
        UIViewController *vc = [[class alloc] init];
        vc.title = dict[kTitle];
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
