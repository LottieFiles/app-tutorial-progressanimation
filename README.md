# Lottie Progress Tutorial

## About

This app demonstrates the usage of Lottie animations:

1. Interaction with animation
2. Controlling progress of animation
3. Example in UIKit and SwiftUI

## Requirements

- iOS 13+
- Swift 5.0

## Extra

Changing color in animation:
``` swift
// log keypaths (after loading animation)
animationView.logHierarchyKeypaths()

// from the logs, get the .Color keypath and use like this
animationView.setValueProvider(ColorValueProvider(Color(r: 1, g: 0, b: 0, a: 1), keypath: AnimationKeypath(keypath: "keypath.Color"))
```

Happy coding! 😀
