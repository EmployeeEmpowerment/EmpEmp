# Employee Empowerment SaaS App
[![Build Status](https://travis-ci.org/EmployeeEmpowerment/EmpEmp.svg?branch=master)](https://travis-ci.org/EmployeeEmpowerment/EmpEmp)

Requirements:
* Ruby version 2.5.1p57+

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

*IMPORTANT* Replace the not-secret key in config/initializers/devise.rb with a key that is actually secret. If you use the key that is there your database will not be secure. To create a secret key to replace, copy and paste into the config.secret_key of devise.rb run:

```
$ rake secret
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
