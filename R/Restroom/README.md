# Running R using Rake Tasks

This app uses Rake Tasks to execute R programs.

[Read this tutorial](http://www.chrisjmendez.com/2017/01/19/installing-r-using-homebrew/) to learn how to install Ruby, Rake and R on a Macintosh computer. 



## Why Rake Tasks?

Ruby Tasks are perfect for situations where you want to run commands into terminal.  

Rake is actually an automation tool.  It's a really nice way to organize your tasks into a neat and tidy place. 




# How Does it Work

The application can be found in ```Rakefile```.  Considering the namespace and the task, you can run the automation through the command line.

```language-powerbash
rake r:run
```



## Run Rake

Simply typing ```rake``` is the default way to run the app. 
```
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

