# WeekdayDatePicker

WeekdayDatePicker is a picker view with day, month and year components and extra auto-adjustable weekday component. Select for example 31st of December 2015 and weekday row will automatically scroll to Thursday.

![WeekdayDatePicker demo](/ReadmeResources/weekdayDatePickerDemo.gif)

### Installation

Recomended approach is to use [CocoaPods](https://cocoapods.org/) dependency manager. Just add 
```
pod 'WeekdayDatePicker', '~> 1.0.0'
```
to your Podfile.

Or you can drop entire WeekdayDatePicker directory straight to your project. This is demonstrated by the example project.

### How to use it

Drag UIDataPicker to your view and set class to `BoSWeekdayDatePickerView`. 


Alternatively you can create it directly in the source code
```
BoSWeekdayDatePickerView *weekdayDatePickerView = [[BoSWeekdayDatePickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 216.0f)];
```

In both cases don't forget to set minimum, maximum and initial selection dates. For example:

```
NSDate *minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:1 month:1 year:2000];
NSDate *maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:31 month:12 year:2020];
NSDate *initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:8 month:8 year:2015];

[weekdayDatePickerView setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];
```

### Internationalization and localization

Date picker will adjust components order to 'Region Format' selectedin the Settings -> General. For example United Kingdom format will result in day-month-year order and United States will have month-day-year.

In order to see weekday names in a language of your choice, follow standard procedure to add the localization. Good tutorial is on the [Ray Wenderlich's page](http://www.raywenderlich.com/64401/internationalization-tutorial-for-ios-2014). Example project has already got the Polish locale enabled.

### Appearance

Basic WeekdayDatePicker's appearance is implemented in `BoSWeekdayDatePickerAppearance` class. I've set 13 point Helvetica Light font, colored with 13% gray and some arbitrary spacings and indentations for component labels. Feel free to modify or replace it with your implementation.

### Limitations

Only Gregorian calendar supported. Also components don't "loop". And WeekdayDatePicker leaks in projects with manual memory management, so ARC is a must. 

### Class architecture (diagram)

![Class diagram image](/ReadmeResources/ClassDiagram.png)

### Licence

MIT