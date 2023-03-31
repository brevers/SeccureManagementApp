# Project Management App
A minimal management app allows organizations to track projects across different departments.

This repo contains two branches designed to showcase secure and vulnerable implementations according to OWASP's Top 10 vulnerabilities. These are the ones we cover:

## Broken Authentication
In both cases, we use Devise to authenticate users, but in the **secure** branch we
strengthened the password policy and, more importantly, added two-factor authentication that
usually helps to secure apps even when regular passwords are weak.

## Broken Access Control
In the **secure** branch, access to resources is always limited by the current user access rights, accounting for the organization the users belong to and their role in the system. IDs are not predictable; even if an attacker can guess one of those, the system will prevent access to the resource at the controller level.

On the insecure branch, the story is a bit different. IDs are predictable, and all the look-up operations are based on those IDs, so while not possible straight out from the views, attackers could access resources by guessing the correct URL. (Same thing for internal users escalation. For instance, a QA person accessing Admin stuff.)

## Injection
Regarding SQL injection, both branches count with the basic protection that Rails provides out of the box. Still, in the **vulnerable** one, we made some intensional mistakes like handcrafting SQL commands using params from userland. (e.g. `[TODO:]`)

## Vulnerable and Outdated Components
In the **secure** branch, we add three checkers that helps to prevent using outdated or vulnerable libraries.

[TODO: Links to tools' websites]

```
$ brakeman

$ bundle audit check --update

# (With special security settings)
$ Rubcop
```

## Server-Side Request Forgery
The secure branch includes anti-forgery tokens on every form, whereas the vulnerable one is susceptible to CSRF attacks.


## How to switch between implementations
The following two sections contain detailed instructions on setting up and running this app's secure and vulnerable versions.

### Secure branch
To run the app in "secure" mode, please run these commands

```
$ git checkout secure

# Install dependencies
$ bundle install

# Create or re-create the database
$ rake db:drop
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

The secure branch comes with 2FA that uses the Devise-Two-Factor gem that uses ActiveRecord encrypted attributes, which in turn uses Rails' encrypted credentials. So, to activate that feature, first, run the following:

```
$ ./bin/rails db:encryption:init
```

The previous command will print the required keys to the terminal. It should look
something like this:

```
active_record_encryption:
  primary_key: EGY8WhulUOXixybod7ZWwMIL68R9o5kC
  deterministic_key: aPA5XyALhf75NNnMzaspW7akTfZp0lPY
  key_derivation_salt: xEY0dt6TZcAMg52K7O84wYzkjvbA62Hz
```

Use those values to configure these ENV vars:

```
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY=
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY=
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT=
```

Once everything is set and done:

```
# Make sure we have no errors so far
$ rails t

# Start the rails server
```

Log in to the system using a demo user and have fun. For instance:
```
user: admin@example.com
pass: Test1234!
```

### Vulnerable branch
To run the app in "vulnerable" mode, please run these commands

```
$ git checkout vulnerable

# Install dependencies
$ bundle install

# Create or re-create the database
$ rake db:drop
$ rake db:create
$ rake db:migrate
$ rake db:seed

# Make sure we have no errors so far
$ rails t

# Start the rails server
```

Log in into the system using a demo user and have fun. For instance:
```
user: admin@example.com
pass: Test1234!
```

