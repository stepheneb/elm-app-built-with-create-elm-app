
### initial commit: 20190426:100

Create a new Elm App using [Create Elm App](https://github.com/halfzebra/create-elm-app).

Install `create-elm-app` globally:

```
% npm install create-elm-app -g
+ create-elm-app@3.0.6
added 1561 packages from 719 contributors in 485.994s
```
This install took about eight minutes on the internal thoughtbot network
and installed 1561 packages!

Generate the initial app.

```
% create-elm-app elm-create-elm-app-app1

Creating elm-create-elm-app-app1 project...

Starting downloads...

  - elm-explorations/test 1.0.0

Dependencies ready!
Success! Compiled 1 module.

Project is successfully created in `/Users/stephen/dev/elm/sandbox/elm-create-elm-app-app1`.

Inside that directory, you can run several commands:

  elm-app start
    Starts the development server.

  elm-app build
    Bundles the app into static files for production.

  elm-app test
    Starts the test runner.

  elm-app eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!

We suggest that you begin by typing:

  cd elm-create-elm-app-app1
  elm-app start
```


OK ...

```
% cd elm-create-elm-app-app1
% elm-app start
```

Running the `start` command started app and opened Chrome to: http://localhost:3000/

Changes to Elm code are hot-reloaded into browser.
