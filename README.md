
# HeatGeek iOS Tech Task - Louis Rushton

  

In this README I'll outline my approach to the design, what I think could be improved, and the extra features I was able to include!

  

## Design

My go-to architecture for testability and separation of concerns is MVVM, which is what I used for this task. 

For the on-device storage, I thought about going with userDefaults, but decided to challenge myself to learn and use SwiftData instead. With iOS 17 as the minimum deployment version, alongside the Observation and Swift Concurrency frameworks, I thought it would be appropriate to use the latest storage framework as well! I have also tried to take into account thread safety with the StorageManager actor I made, with the @ModelActor macro providing serialised access to the DB.

All of the networking is done using Swift Concurrency.

For the UI, I decided to keep it simple for this first iteration, so standard iOS colours and components are in use across the app.

## Features

Along with the requirements, I also implemented a couple of additional features:

- Character sorting by film count
- Fetch next page by scrolling down and pressing the "plus" button
- Network error recovery with retry button
- Star icon overlay indicating "favourited" in character details
- Loading states for the list and images
  

## Main User Journey




https://github.com/l-rushton/DisneyExplorer/assets/89603800/dbb39103-981b-46e9-b5c1-34b19ebbeb21


  

## Error Recovery

  


https://github.com/l-rushton/DisneyExplorer/assets/89603800/28c5b049-261b-4d6b-8aa4-954f2b736153





## Future Improvements

  

There are some areas which I would polish if I had more time, especially with the UX, but everything is functional. These are a few things I could improve if I were to continue development on this project:

- Make UI more colourful
- Mock out StorageManager using a protocol for better testing 
- Tap on favourite picture to navigate to details page
- Implement animations for favouriting characters
- Add UI and snapshot tests
- Add search function
- Stored images so they don't have to be fetched every time by AsyncImage
- Automatic loading of new results when scrolled to the bottom
- Splash screen
  

# Thank you for reading!
