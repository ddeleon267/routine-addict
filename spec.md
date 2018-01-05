# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
* Sinatra gem was added to the project's gemfile, to handle routes, templating and actions.

- [x] Use ActiveRecord for storing information in a database:
* Both ActiveRecord and sqlite3 gems were added to the project's gemfile, and its characteristics to models and environment, also the use of migrations to associate models with the database.

- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
*__3_ models classes were included in this project*
* User
* Routine
* Product

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)

* A User has_many :routines => Routine belongs to :user
* A Routine has_many :routine_products => RoutineProduct belongs to :routine
* A Routine has_many :products, through: :routine_products
* A Product has_many :routine_products => RoutineProduct belongs to :product
* A Product has_many :products, through: :routine_products

- [x] Include user accounts
* An user model and a users controller were created. The bcrypt gem was added to the project's gemfile to encrypt its password; sessions were enabled as well.

- [x] Ensure that users can't modify content created by other users
* User controller was built to only allow current_user to modify its own routines by checking its session user id before making any changes. Similarly, the views allow only the current user associated with a routine to see the options to edit or delete a routine.

- [x] Include user input validations
* Parameters inserted in forms are validated before any action its taken, and user is warned and re-routed if any invalid data is present.

- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
* flash-sinatra gem was added to the project's gemfile and required once in the ApplicationController to add custom messages in case of any invalid data.

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
