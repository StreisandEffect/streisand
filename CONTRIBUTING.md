## Contributing Issues and Bug Reports

Thanks for your interest in helping improve Streisand! This documentation page
has some helpful tips and things to keep in mind to make your
contributions to Streisand as great as they can be.

### Keep it Positive/Empathetic

Encountering bugs is a frustrating experience! Missing features speak to
unaddressed needs. We understand that and want to help.

Please also remember that Streisand is 100% a volunteer effort. Nobody is paid
to work on Streisand, and nobody does it as their full time job.

Where possible try to keep discussion tone positive and remember that the folks
working on Streisand fit it into their spare time between other real life
commitments (family, vacation, jobs, hobbies, relaxation!).

### Which Repository?

If your issue is a question or you need help with setting up / configuring Streisand, then please ask on the [streisand-discussions](https://github.com/StreisandEffect/streisand-discussions/) Github repository. 

Similarly, if you are requesting a new feature we prefer it be done on the [streisand-discussions](https://github.com/StreisandEffect/streisand-discussions) Github repository.

### Before Submitting an Issue

Before submitting new issues please do a search in [open issues](https://github.com/StreisandEffect/streisand/issues) to see if the issue or refinement you have in mind has already been suggested. For features/questions search [the streisand-discussions open issues](https://github.com/StreisandEffect/streisand-discussions/issues).

If you find your issue already exists, feel free to add constructive comments such as new information, additional insights on how to reproduce, etc. If you're only interested in sharing that the feature is important to you, or that the bug affects you then add a [reaction](https://github.com/blog/2119-add-reactions-to-pull-requests-issues-and-comments). Using reactions in place of a "+1" or "me too!" comments helps keeps the conversation clear and concise.

👍 - upvote

👎 - downvote

If you cannot find an existing issue that describes your bug or feature, submit a new issue using the guidelines below.

## Writing Good Bug Reports and Feature Requests

Describe a single problem or feature request per issue. Do not include multiple bugs or feature requests in the same issue.
The more information you can provide, the more likely someone will be successful reproducing the issue and finding a fix. 
#Take advantage of Github Markdown styling to make your issue easier to read. For example, Wrap single line code statements or logs in single backticks: \` code here \`. Wrap multi-line in triple backticks: \``` multi-line code here \```. 

#### Streisand Diagnostics File

Streisand automatically creates a markdown file in the project directory called
`streisand-diagnostics.md`. Every time you run Streisand this file is populated
with some basic diagnostic information about your system & Streisand options
that are enabled.

Sharing the contents of this file in new issues is a great way to answer a lot
of required questions without having to do any work besides copy & pasting!

#### What Other Information to Include in Your Issue

Please try your best to answer all of the questions in [the Streisand Issue template](https://github.com/StreisandEffect/streisand/blob/master/.github/ISSUE_TEMPLATE.md). Answering these questions help us skip a lot of "Github telephone tag" that takes up time that could be used fixing the bug.

When describing your issue focus on:

* Reproducible steps (1... 2... 3...) and what you expected versus what you actually saw.
* Log output from Ansible or other relevant services, ideally linking to a Gist for longer log output.
* Information about your system (OS, version, etc)
* Information about the target Streisand server (cloud provider, etc)

Don't feel bad if we can't reproduce the issue and ask for more information.
It's impossible to know what questions will be most relevant for every potential
bug!

#### Why Was My Issue Closed???

Issues are generally closed for one of three reasons:

1. There wasn't enough information or nobody has been replying to questions
   asked.
2. The issue was created on the wrong repository and should have been created as
   a [streisand-discussions](https://github.com/StreisandEffect/streisand-discussions)
   issue or vice-versa.
3. After discussion and evaluation it was determined the problem was fixed or
   wasn't appropriate for Streisand

We try very hard to keep the issue list clean. Don't feel bad if your issue
was closed, it can always be reopened if there are disagreements to discuss
or the situation has changed.

## Contributing Fixes

If you are interested in fixing issues and contributing directly to the code
base please feel free to submit a PR. We're excited to help! If there is an
existing issue for the problem you are interested in fixing please leave a quick
comment indicating that you'd like to start working on a solution. That way we
can avoid duplicating work. Similarly, talking about how you plan to implement
a fix or a new feature ahead of starting gives folks a chance to give early
design input which will save time later during code review!

#### CI Testing

Streisand uses [Travis CI](https://travis-ci.org/jlund/streisand) for continuous
integration testing. Make sure to read
[testing.md](https://github.com/StreisandEffect/streisand/blob/master/documentation/testing.md)
where we describe the tests that are run, how to work around breakages for
features unsupported by LXC, and tips for developing on localhost with Vagrant.
All PRs will have to pass CI to be merged. Feel free to submit a PR with broken
CI if you need help getting the tests to pass.

#### Code Reviews

All PRs need at least one approved code review from a maintainer in order to be
merged. Maintainers may not review their own pull requests.

Streisand is a volunteer effort. Please allow at least 7 days to pass before
following up on missing reviews. If more than 7 days have elapsed and you are
still waiting on a review or a reply from a maintainer please leave a friendly
"bump" message and "@ mention" their username.

#### Modularity

We've recently begun working on modularizing Streisand so that installations can
be customized to include/not include certain VPN services. Additions to
Streisand should endeavour to fit into this model. We describe the philosophy
and design patterns used in this approach in
[modular_roles.md](https://github.com/StreisandEffect/streisand/blob/master/documentation/modular_roles.md)

