JSHint (JSHint-Gecko)
==================================================

Customize JSHint for special usage on mozilla/gecko RIL related code.

**Code**

* RILContentHelper.js
* RadioInterfaceLayer.js
* ril_worker.js
* ril_consts.js

**Modification**

* Modify controlling directive for fallthrough in switch case to `// Fall through`
* Ignore errors for redefined `let` variable, ex: `let foo = function foo() {}`
* Provide sample `.jshintrc`
* Provide wrapper command `jshint-gecko` that could handle `importScripts()` used in worker code

**Presentation**

[Improve Code Quality of RIL Code by JSHint](https://speakerdeck.com/aknow/improve-code-quality-of-ril-code-by-jshint)


Install & Update
----------------

Run the following command. (Note: You don't have to clone the repository.)

    curl https://raw.github.com/aknow/jshint-gecko/master/install.sh | bash

**Behind the script**

* Install `nodejs` (if not existed) by `nvm`  to `~/.nvm`
    -  Add following lines to `~/.bashrc`. It enable the node and add the support for
`sudo node`

            . ~/.nvm/nvm.sh
            nvm use ${NODE_VERSION}
            alias sudo='sudo '

* Uninstall existed jshint
* Inatall jshint globally from this repository
* Create default `.jshintrc` in `~/.jshintrc`
* Create wrapper command in `/usr/bin/jshint-gecko` (invoke sudo in this step)


Usage
-----

    jshint-gecko <js-file>


As a Plugins for Vim
--------------------

* Use [syntastic](https://github.com/scrooloose/syntastic) and modify
`$VIM/bundle/syntastic/syntax_checkers/javascript/jshint.vim`

![modify for syntastic](https://raw.github.com/aknow/jshint-gecko/master/gecko/syntastic_modify.png)

* Add following lines in your .vimrc

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_javascript_checkers = ['jshint']

syntastic trigger the syntax check when saving the file and populate the results
to location-list-window. You could type `:lwindow` in Vim to open the window.

