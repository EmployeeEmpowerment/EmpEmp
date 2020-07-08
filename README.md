# Employee Empowerment SaaS App ( [EmpEmp.org](https://EmpEmp.org) )
[![Build Status](https://travis-ci.org/EmployeeEmpowerment/EmpEmp.svg?branch=master)](https://travis-ci.org/EmployeeEmpowerment/EmpEmp)

Requirements:
* Ruby version 2.7.0+

## Getting started

To get started with the app, first clone the repo and `cd` into the directory:

```
$ git clone git@github.com:EmployeeEmpowerment/EmpEmp.git
$ cd EmpEmp
```

Install the needed gems (while skipping any gems needed only in production):

```
$ bundle install --without production
```

Install JavaScript dependencies:

```
$ yarn install
```

Install Postgres:
* This is a rather tedious process and very operating system dependent. I recommend using [this guide](https://devcenter.heroku.com/articles/heroku-postgresql#local-setup). Alternatively, you can revert the changes from Issue #16 to return to SQLite in your personal fork. Good luck!

Setup Devise:
You need to set the DEVISE environment variables. Here is a way to do it prior to running rake or launching the server. It's better to use a more permanent method like secrets.yml.

```
$ export DEVISE_SECRET=$(rake secret)
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rake
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## License

All source code is available under the MIT License. See [LICENSE](LICENSE) for details.
