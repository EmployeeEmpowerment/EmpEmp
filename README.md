# Employee Empowerment SaaS App
[![Build Status](https://travis-ci.org/ForestJay/EmpEmp.svg?branch=master)](https://travis-ci.org/ForestJay/EmpEmp)

Requirements:
* Ruby version 2.5.1p57+

## Getting started

To get started with the app, first clone the repo and `cd` into the directory:

```
$ git clone https://github.com/ForestJay/EmpEmp.git 
$ cd EmpEmp
```

Then install the needed gems (while skipping any gems needed only in production):

```
$ bundle install --without production
```

Install JavaScript dependencies:

```
$ yarn install
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## License

All source code is available under the MIT License. See [LICENSE](LICENSE) for details.
