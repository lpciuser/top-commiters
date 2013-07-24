#GitHub Top Commiters
Provide basic github API wrappers and couple of helper classes to build ratings for the repository committers.
For testing purpose there is command line tool to build ratings based on GitHub::Commit data.

## Installation

    git clone git@github.com:Mugimaru/top-commiters.git
    cd top-commiters
    bundle install
    
To start using GitHub API you should replace TOKEN in lib/github/client.rb with valid GitHub OAuth token 
## Usage
To use CLI commands, in project directory run

    bundle exec bin/rating
Or make it executable

    chmod u+x bin/rating # once
    bin/rating # to run cli
### CLI Ratings builder examples
##### Build rating of mugimaru/top-commiters commits by number of deletions

    bin/rating -r mugimaru/top-commiters sha stats/deletions
##### Build rating of mugimaru/top-commiters committers by number of insertions

    bin/rating -r mugimaru/top-commiters user stats/insertions
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
