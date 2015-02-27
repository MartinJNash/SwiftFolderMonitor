## Swift File Monitor

Monitor a directory in your filesystem for changes.

```swift
let url = NSURL(fileURLWithPath: "~/Desktop".stringByExpandingTildeInPath)!
let monitor = FolderMonitor(url: url, handler: {
    println("Found change")
})
```

You can also pause and resume getting callbacks. Don't worry about balancing calls to start and stop. I took care of that for you. ;)

```swift
monitor.start()
monitor.stop()
```



## Inspiration

- [Cocoanetics -- Monitoring a Folder With GCD](http://www.cocoanetics.com/2013/08/monitoring-a-folder-with-gcd/)