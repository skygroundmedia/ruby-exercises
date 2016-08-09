#CSV to JSON Example 2
-

This demo is designed to adapt data within a CSV file to JSON using ruby.   There are many ways to accomplish this but we've chosen to use a few tools to make JSON rendering easier.  



# Getting Started

You will need to install Ruby on Rails. Thankfully, if you're writing Ruby apps, it probably means you already have rails installed. 

```
gem install rails --no-ri --no-rdoc  
```


Next step is to run ```bundle install```.  This will provide you with the necessary gems to get this application up-and-running.


---


# Running the App

Run the app:

```
ruby app.rb
```

The app was written in an OOP way in order to show developers how a ```CSV``` type utility can be integrated into their existing projects. 


---


## Notes about CSV

- CSV looks for the first two to serve as the column headers. The app has been configured to automagically convert string headers into :symbols. 

- CSV is slower than other gems but it comes installed by default.

- ```active_support/core_ext/object/blank``` is a quick way to load the ```blank?``` method from Rails. 


---


## Notes about JSON

- ```active_suppor/JSON``` is being used to print Ruby objects into JSON. You need that in conjunction with ```neatjson```.

- ```neatjson``` is designed to help make the JSON look even prettier. 


