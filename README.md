# WeekdayDatePicker

WeekdayDatePicker is a picker view with day, month and year components and extra auto-adjustable weekday component. Select for example 31st of December 2015 and weekday row will automatically scroll to Thursday.

![WeekdayDatePicker demo](/ReadmeResources/weekdayDatePickerDemo.gif)

### Installation

Recommended way of installing is via [CocoaPods](https://cocoapods.org/). Add the following lines to your Podfile:
```
pod 'WeekdayDatePicker', '~> 1.1.0'
```

Alternatively just drop entire WeekdayDatePicker directory straight to your project. This is demonstrated by the example project.

### How to use it

#### Setup
In the Interface Builder drag UIPickerView object to your view and set its class to `BoSWeekdayDatePickerView`. 

![Usage demonstration](/ReadmeResources/weekdayDatePickerUsage@2x.png)

Alternatively you can create it directly in the source code. For example:
```
BoSWeekdayDatePickerView *weekdayDatePickerView = [[BoSWeekdayDatePickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 216.0f)];
```

In both cases don't forget to set minimum, maximum and initial selection dates e.g.:

```
#import "BoSWeekdayDatePicker.h"

(...)

NSDate *minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:1 month:1 year:2000];
NSDate *maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:31 month:12 year:2020];
NSDate *initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:8 month:8 year:2015];

[weekdayDatePickerView setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];
```

#### Selection callback
Once you have date picker in place you can start capturing data sent on new row selection (basically from `pickerView:didSelectRow:inComponent:` method). This can be done by implementing public block property from the `BoSWeekdayDatePickerView`:
```
@property (nonatomic, copy) void (^didSelectRowCallback)(BoSWeekdayDatePickerSelectedItems *selectedItems);
```

For example after selection which you can see on the gif above the callback implementation below
```
  weekdayDatePicker.didSelectRowCallback = ^(BoSWeekdayDatePickerSelectedItems *selectedItems) {
    NSLog(@"Selected row values: %@", selectedItems.arrayOfRowValues);
    NSLog(@"Selected date: %@", selectedItems.selectedDate);
    NSLog(@"Index of selected row: %d", selectedItems.indexOfSelectedRow);
    NSLog(@"Index of selected component: %d", selectedItems.indexOfSelectedComponent);
  };
```

will produce the following result:
```
Selected row values: (
    Thursday,
    12,
    31,
    2015
)
Selected date: 2015-12-31 00:00:00 +0000
Index of selected row: 30
Index of selected component: 2
```

### Internationalization and localization

Date picker will adjust components order to 'Region Format' selectedin the Settings -> General. For example United Kingdom format will result in day-month-year order and United States will have month-day-year.

In order to see weekday names in a language of your choice, follow standard procedure to add the localization. Good tutorial is on the [Ray Wenderlich's page](http://www.raywenderlich.com/64401/internationalization-tutorial-for-ios-2014). Example project has already got the Polish locale enabled.

### Appearance

Basic WeekdayDatePicker's appearance is implemented in `BoSWeekdayDatePickerAppearance` class. I've set 13 point Helvetica Light font, colored with 13% gray and some arbitrary spacings and indentations for component labels. Feel free to modify or replace it with your implementation.

### Limitations

Only Gregorian calendar supported. Also components don't "loop". And WeekdayDatePicker leaks in projects with manual memory management, so ARC is a must. 

### Class architecture (diagram)

![Class diagram image](/ReadmeResources/classDiagram.png)

### Licence

MIT
