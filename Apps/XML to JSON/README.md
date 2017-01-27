# Ruby XML to JSON

I wanted to create two scripts for work.  The first script was to create an XML file filled with fake user info.  The purpose of this file is to simulate an existing database I have with data that can only be exported as XML.

The second script is designed to get that XML file and convert it to JSON.

Here's how to run both scripts:

### Getting Started

We first need to download a few Ruby gems that will help us create an XML file and populate it with fake data
```language-powerbash
bundle install
```


## Create an XML file full of user data


```language-powerbash
ruby email_builder.rb
```


## Conver the XML file into JSON

This Ruby script expects to see the XML data within an ```Output``` folder.  It will get the XML file and convert the contents into JSON.
```language-powerbash
ruby email_parser.rb
```


