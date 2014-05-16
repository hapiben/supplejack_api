# SupplejackApi

The Supplejack API is a [mountable engine](http://guides.rubyonrails.org/engines.html) which provides functionality to store, index and retrieve metadata via an API.

For more information on how to configure and use this application refer to the [documentation](http://digitalnz.github.io/supplejack)

## Usage

[Install & Setup instructions](http://digitalnz.github.io/supplejack/start/install-setup.html)


## Engine Development

### Rails console

```
cd spec/dummy/
bundle exec rails console
```

### Rails server

```
cd spec/dummy/
bundle exec rails server
```

### Solr

```
bundle exec rake app:sunspot:solr:start
``` 

This will start the server based on the configuration in `config/sunspot.yml`

```
bundle exec rake app:sunspot:solr:stop
```

## Engine Testing

### Rspec Specs

From the root of the engine, run 

```
bundle exec rspec spec/
```

This uses `spec/dummy` to mount the engine into and then runs the specs.

### Cucumber Features

From the root of the engine, run

```
bundle exec cucumber features/
```

This uses a test Solr instance from `spec/dummy/solr` in order to test searching.

## COPYRIGHT AND LICENSING  

### MAJORITY OF SUPPLEJACK CODE - GNU GENERAL PUBLIC LICENCE, VERSION 3  

Except as indicated below, Supplejack, a tool for aggregating, searching and sharing metadata records, is Crown copyright (C) 2014, New Zealand Government. Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. http://digitalnz.org/supplejack  

Except as indicated below, this program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.   

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.  

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses / http://www.gnu.org/licenses/gpl-3.0.txt 

### SUPPLEJACK API SUNSPOTSESSIONPROXY  

The Supplejack API SunspotSessionProxy was authored by HeyZap (http://www.heyzap.com/) and is available at http://stdout.heyzap.com/2011/08/17/sunspot-resque-session-proxy/.
