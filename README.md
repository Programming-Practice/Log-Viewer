# Development Process
## Pick a Story to Start
The next work you choose should always be the top most story in the project backlog.

## Entry Meeting
Most stories will require that you hvae an Entry meeting.  Schedule an entry meeting including all interested parties (Documentation, Validation, Developers, Product Owner)
The purpose of an entry meeting is to:
- Define what needs to be done as part of the story
- Determine how to test when complete

## Start your work
- Create git Branch

``` shell
git checkout -b [branch_name]
```

- Start by creating tests first

## When all work is done
Perform Developer Testing to ensure all features are implemented and function properly. You will also want to make sure that your tests succeed.

Push the changes to git:

``` shell
git add .
git commit -m "Include a comment of the changes made here"
git push origin [branch_name]
```

## Create a pull request in Github
Go to your project in [Github](https://github.com/Programming-Practice/Log-Viewer).  Most of the time github will be able to determine that you have made changes in a branch and show you a button to create a `pull request`.  After you click the create pull request button, it will give you an option to specify a short title and a place to enter more details about the pull request.  In the message body for the pull request use the property template to Link in Pivotal Tracker card.

This template includes:

- Links to pivotal tracker card
- What changes were made
- How to test the changes

Create the pull request and wait for reviewers to comment.  When at least 2 developers have reviewed and given thumbs up to your changes you may merge your pull request
