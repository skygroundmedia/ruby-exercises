# Advanced Simulation using Ruby and R


This application has three distinct processes:

* Process #1 uses Rake to run both a simulation and analysis
* Process #2 uses Ruby to simulate 70 people in an office using a bathroom. 
* Process #3 uses R to analyze the simulation and determine if a single bathroom with 3 stalls can comfortably handle 70 office workers needing to use the restroom 3 times a day. 

## App Assumptions

* The probability of a person going to the restroom is randomly set to one to six times within a period of nine hours.
* The probability of any person going to the restroom during the half-hour before lunch until the half-hour after lunch (two hours in total) is higher than any other time over the period of nine hours.
* A person can use the restroom for 1 or 2 minutes.
* There are a few restroom with 3 facilities and its own queue.

# Install


[Read this tutorial](http://www.chrisjmendez.com/2017/01/19/installing-r-using-homebrew/) to learn how to install Ruby, Rake and R on a Macintosh computer. 


## Why Rake Tasks?

Ruby Tasks are perfect for situations where you want to run commands into terminal.  

Rake is actually an automation tool.  It's a really nice way to organize your tasks into a neat and tidy place. 


---


# How Does it Work


## Starting App

The application can be found in ```Rakefile```.  Considering the namespace and the task, you can run the automation through the command line.

```language-powerbash
rake
```




## Command Line Arguments

Show a list of available rake tasks.
```
rake --tasks
```


Get the whole list of arguments.
```
rake -h
```



---



# Managing External Libraries

We're using ```Gemfile``` to help keep things nice and organize. If you're just getting started, run this command to install any necessary gems.

```
bundle install
```

---


# Debugging

We're using ```pry``` for debugging purposes. [Learn more](https://github.com/pry/pry).


```language-ruby
#ruby code
def random_method
  ...
  binding.pry
end
```
