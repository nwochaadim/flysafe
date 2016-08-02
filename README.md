## Fly Safe [![CircleCI](https://circleci.com/gh/andela-anwocha/flysafe/tree/develop.svg?style=svg)](https://circleci.com/gh/andela-anwocha/flysafe/tree/develop) [![Coverage Status](https://coveralls.io/repos/github/andela-anwocha/flysafe/badge.svg?branch=ft-booking-page-management-121376557)](https://coveralls.io/github/andela-anwocha/flysafe?branch=ft-booking-page-management-121376557) [![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/andela-anwocha/flysafe/badges/quality-score.png?b=ft-booking-page-management-121376557)](https://scrutinizer-ci.com/g/andela-anwocha/flysafe/?branch=ft-booking-page-management-121376557)

A flight booking application that allows users to make booking reservations. It can be viewed online [here](https://fly-safe.herokuapp.com)
## Getting Started
1. Clone the repository:
    ````
    $ git clone https://github.com/andela-anwocha/flysafe.git
    ````

2. Navigate into the cloned repository folder:
    ```
    $ cd flysafe
    ```

3. Install dependencies:
    ```
    $ bundle install
    ```

4. Setup database:
    ```
    $ rake db:setup
    ```

5. Seed database with fake flight information:
    ```
    $ rake db:seeds
    ```

## Usage
1. Start rails server
    ```
    $ rails s
    ```

2. Navigate to your browser and type in: http://localhost:3000

## External Dependencies

|        Production |  Testing/Development
|-------------------|----------------------
| Rails Framework   | Letter Opener
| Puma server       | Guard
| Rails_12 Factor   | SQLiite3
| Pg                | Pry-rails
| Postgre SQL       | Shoulda-matchers
| Bcrypt            | Database-cleaner
| Paypal Express    | Selenium Driver
| Toastr-rails      | Spring
| Semantic-UI       |
| Jquery-Rails      |

## Running Tests

1. Make sure "rspec" is installed by running:
    ```sh
        $ bundle show rspec
    ```
    If a path is listed, then rspec is installed.

2. Run rspec for the spec folder through bundle:
    ```sh
        $ bundle exec rspec spec
    ```


## Features

1. Users can search for flights based on the following criteria: **flight date**, **destination airport**, **departure airport** and **number of passengers**
2. Users can make booking reservations for flights
3. Users can make flight payments via paypal
4. Allows registered users to edit and cancel booking reservations.
5. Users can search booking reservations via booking reference number
6. Instantly notifies users on successful booking reservations or upon update of existing bookings.

## Limitations

1. Does not send notifications to users via sms


## Contributing

1. Fork it: [Fork the flysafe project](https://github.com/andela-anwocha/flysafe/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request