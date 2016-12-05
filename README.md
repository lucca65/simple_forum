## SimpleForum ##
[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)


Hi! Warm welcome for you.

Let's get started, do this stuff to get the app running:

  * Make sure that you have Elixir installed. Instructions for that [here](http://elixir-lang.org/)
  * Clone this repo with `git clone https://github.com/lucca65/simple_forum_elixir.git`
  * Go grab your dependencies before loading it up `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install frontend stuff by running `npm install`
  * Happily start `iex`, `phoenix`, `storage` and other stuff with `iex -S mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Many Stuff going on. Let's go bit by bit

### Main Objectives ###

* Thread creation
* Thread commenting
* Language censorship
* Update notices via e-mail


#### Thread creation ####

This is handled by regular phoenix app. Just normal IO stuff, you can try doing some of those stuff [here](http://www.phoenixframework.org)

#### Thread commenting ####

As well regular phoenix stuff, but with a catch. We recursively build the comments tree, adding a margin to its child so it is easier on the eyes to keep track of what is going on

#### Language Censorship ####

This is handled by the `SimpleForum.Blacklist` and `SimpleForum.Storage`.

`SimpleForum.Storage` is an Agent. That is a long lived process that is only used to maintain state. Elixir is a functional language, so our stuff just vanish when we are not in current clojure anymore. So to make it work we create an Agent, more on that [here](http://elixir-lang.org/getting-started/mix-otp/agent.html)

The starting rules for our app reside on `SimpleForum` module. There we call two funcions (`register_storage/0` and `load_db/0`) responsible to read a local file containing the black words, and load it to our agent (remember, its `SimpleForum.Storage`)

Upon `SimpleForum.Thread` creation, we first clear it of black words by calling `SimpleForum.Blacklist.filter/1`. It calls the entire blacklist, and recursively clears all matches. This could also be achieved by the use o Regex, but for simplicity sake's its done that way.

#### Update notices via e-mail ####

This funcionality basically relies on theses Modules: `SimpleForum.Miner`, `SimpleForum.Mailer` and `SimpleForum.Scheduler`

`SimpleForum.Miner` calls some 'scope-like' functions from `SimpleForum.Thread` to compose a tree of comments that occured today, mounts these threads updates as emails for everyone engaged on a thread. It then sends an email for everyone with those updates.

This module does a lot more than it should, but again: _simplicitiy_. Again we can get enougth of this.

`SimpleForum.Mailer` only loads mail stuff that we need to get it working.

`SimpleForum.Scheduler` uses **absurd** simplicity to recursivily schedule async job. Really you should check it out, is _very simple_. Beside of this awesomeness it only calls `SimpleForum.Miner.main` that sends the email to everyone

That's all folks!

Here is a gif so we can all be happy about life.

![http://i.giphy.com/l2JhOs6DLZad0rEwo.gif](http://i.giphy.com/l2JhOs6DLZad0rEwo.gif)
