## Fly Safe [![CircleCI](https://circleci.com/gh/andela-anwocha/flysafe/tree/develop.svg?style=svg)](https://circleci.com/gh/andela-anwocha/flysafe/tree/develop) [![Coverage Status](https://coveralls.io/repos/github/andela-anwocha/flysafe/badge.svg?branch=ft-booking-page-management-121376557)](https://coveralls.io/github/andela-anwocha/flysafe?branch=ft-booking-page-management-121376557) [![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/andela-anwocha/flysafe/badges/quality-score.png?b=ft-booking-page-management-121376557)](https://scrutinizer-ci.com/g/andela-anwocha/flysafe/?branch=ft-booking-page-management-121376557)

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
