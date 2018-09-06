# Contributing to Denver Startup Week

:tada: Thank you for taking the time to contribute! :tada:

Like everything else with Denver Startup Week, the DSW website is an entirely
volunteer-powered effort. The following is a set of guidelines for contributing
to the DSW website. They will equip you with the information needed to make the
most awesome contribution possible and will also make it as easy as possible for
us to help you get your code into production. Pull requests or issues that don't
demonstrate a thoughtful consideration of these guidelines may be closed without
comment at the maintainers' discretion. Help us help you!

## Code of Conduct
This project and all who participate in it are governed by the [Denver Startup
Week Code of Conduct](https://www.denverstartupweek.org/code-of-conduct). By
participating, you agree to uphold it too. Project maintainers, at their sole discretion, reserve the right to block
contributors who violate the Code of Conduct.

## MINASWAN
In addition to asking you to agree to the Code of Conduct, we respectfully remind you that we are all volunteers who maintain this project in our free time. We believe strongly in offering constructive and actionable feedback on pull requests, but the turnaround on something thoughtful is often not immediate. Please be patient! Contributions that demonstrate a blatant disregard for the maintainers' time, that create unnecessary extra work in order to be reviewed, or that are otherwise rude or disrespectful will not be accepted.

## What do I need to know before getting started?
Denver Startup Week is the largest free entrepreneurial event in North America.
Held every fall, it is a week-long celebration of entrepreneurship and
innovation in Denver and the surrounding area. It is made possible thanks to a
dedicated team of volunteers and generous sponsorship from multiple community
partners.

You are encouraged to explore the [Denver Startup Week
Website](https://www.denverstartupweek.org) to learn more about the event and get a feel for content,
structure, etc.

We maintain a list of open issues and have done our best to tag them, especially
the ones that might be good for first-time contributors. We suggest reviewing
that list, especially if you're not sure what to work on.

We also recommend reviewing the codebase to get a sense of overall project style
and how we like to test.

## How do I claim an issue?
You may claim an issue by commenting on any open, unassigned issue. We may
respond by asking you to self-assign that issue, or we may ask you to pick a different issue. You
are certainly welcome to simply begin working on something, but we may opt to not
accept a pull request in the event of any parallel effort on that work.

Please do not add any new issues without first ensuring that the issue has not
already been entered.

## How do I submit a pull request?
Before submitting a pull request, please take a few minutes to ensure that
you've considered the following:
- [ ] You've rebased the latest changes from master into your branch and
  addressed any merge conflicts (no merge commits, please).
- [ ] You've addressed anything caught by the linter. Sometimes, Hound will
  complain once you've pushed up a PR; please address these by
  squashing/amending commits.
- [ ] You've squashed any WIP or similar commits.
- [ ] Commit messages are descriptive and reflect what was changed. For example, `fixes styling bug on contact page` and not `address issue #10`.
- [ ] You've included a helpful description of your work in the pull request and
  have referenced any relevant issues.
- [ ] You've run the test suite and all tests are passing. **It is your
  responsibility to fix any tests that you break!** We will not merge any PR that
  breaks the test suite on CI.
- [ ] You've added any additional tests of your own, as needed, to cover new or
  changed functionality.

If you would like to open a pull request that is not yet ready for review,
please add the `WIP` label to signal that you are still working. Don't forget to
remove the `WIP` label when you feel that your code is ready for review.
