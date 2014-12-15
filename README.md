todo-fluxxor-coffee
===================

### Running

```
$ coffee index.coffee
```

### Compiling bundle.js

```
$ browserify -t coffee-reactify --extension=".coffee" src/app.coffee > www/js/bundle.js
```
