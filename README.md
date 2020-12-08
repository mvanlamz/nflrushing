# theScore "the Rush" Interview Challenge
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home challenge?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (like Elixir/Phoenix, Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Challenge Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo is a sample data file [`rushing.json`](/rushing.json).

##### Challenge Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of [`rushing.json`](/rushing.json)
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted data as a CSV, as well as a filtered subset
    
2. The system should be able to potentially support larger sets of data on the order of 10k records.

3. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

### Installation and running this solution

#### NFL Rushing by Mike van Lammeren

Install "asdf" to manage system dependencies

  * Follow instructions here: [`https://asdf-vm.com`](https://asdf-vm.com/#/core-manage-asdf?id=install)

Use "asdf" to install system dependencies

  * Install elixir `asdf install elixir 1.10.4`
  * Install erlang `asdf install erlang 23.0.1`
  * Install nodejs `asdf install nodejs 12.9.1`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Additional steps:

  * Run the unit test suite with `mix test`
  * Import rushing.json to your database with `mix load_json`
  * (Optional) Start app to automatically run unit tests with `mix test.watch`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser!

#### Notes from Mike van Lammeren

Although I have over three years of full-time Ruby development experience, and only a few months of Elixir experience, I chose to do this project with Phoenix. Ruby is awesome, of course, but Elixir is almost as fun for developers, and runs so much faster than Ruby, that to me, it is the obvious choice. This little sample application, running on my anemic old MacBook Air, can return an HTML page with hundreds of records in 25 ms, and a CSV file with the same information in 10 ms. Amazing!

When I write software, the first thing I do is meet the absolute minimum requirements. This is key to agile software development. If circumstances reduce the time available to developers, or make a team switch tasks, then at least the minimum requirements will be met. For example, this solution only searches player's full names. It would be better to use the PostgreSQL `ilike` query to search for part of a name, but given time constraints, it is preferable to have a simple feature that works, over a complex feature that is unfinished.

I typically work following TDD, which means that whenever I need to stop, my unit test suite is already complete. I don't need to skip writing tests due to a time crunch. Finally, because the code is fully unit-tested, I can always re-factor the code to make it more beautiful, without worrying about breaking anything.

Design Decisions
  * I wrote a quick `mix load_json` task to import the rushing.json file. If this was going to be used again, then I would make it more robust, with error-checking, etc.
  * I decided to split the `Lng` (Longest Rush) field into two fields. In the JSON input file, a trailing `T` is a sentinel value, indicating a touchdown. I split it into an Integer and Boolean field instead of storing it as a string in one, single field, which prevents the need for ugly, slow SQL queries down the road.
  * My unfamiliarity with NFL rushing stats led me to give the fields longer names than an avid sports fan would need. I included long descriptions in header tooltips as well. Developers and users that are new to this sort of thing might appreciate those things.
  * I left the CRUD boilerplate in place, just in case testers want to modify the data as part of their evaluation. Of course, the real users shouldn't have that functionality.

TODO
  * need to search for partial player names with a SQL "like" query
  * the CSV output right now can dump over 300 records in 10 ms, but it would use less memory, and support many times the number of records, if it was chunked and streamed
  * add a virtual field in the `rushstats` schema to transparently handle the `yards_max` and `yards_max_touchdown` values
  * replace the Search button with an auto-submit on form change
  * sort by any field, both ascending and descending, by clicking the field title

#### Contact Information

  * Mike van Lammeren
  * [`Mike's LinkedIn Profile`](https://www.linkedin.com/in/mvanlamz/)
