# auto-compose 
Small CLI tool to compose a new file out of others according to a template.

# Background
Witnessing that many of my source files are often composed of other files - like small code snippets which have their own origin and version control. The desire arose to have a tool for which I could simply define a template then add all those smaller code-snippets as submodules. 

So this tool would check which components are available and according to this creates the resulting file. The result is auto-compose

# How?
Requirements
------------
- [nodejs](https://nodejs.org/en/)
- [npm](https://www.npmjs.com/)

Installation
------------

Current git version
```sh
npm install -g git+https://github.com/JhonnyJason/auto-compose-output.git
```

Npm Registry
```sh
npm install -g auto-compose
```

Usage
-----
```
Usage
    $ auto-compose arg1

Options
    optional:

        arg1, --path <path/to/root/dir> -p <path/to/root/dir>
            the directory to start autocomposing
            cwd(current working directory) is default
        
        --recursive, -r
            recursive switch, if present it would recursively autocompose
            doing so in depth-first style 
        
Examples
    $  auto-compose /home/user/code/autocompose-sources/ -r

```

Current Functionality
---------------------
- Composition Step
    - Reads the `autocomposition.*.mustache` as the template
    - Reads all Filenames and Directorynames available in the same basePath where the composition ste happens
    - Those components are simply stored as: 
        ```
        file: ./header.coffee
        {
            "name": "header",
            "coffee": "... content of the file ..."
        }
        ```
    - `autocomposition.<extname>.mustache` defines which files extensions are to be considered
    - For directories ony files like `./filename/filename.<extname>` are being considered
    - For the case when we have the case of both `./filename/filename.<extname>` and `./filename.<extname>` being available then `./filename.<extname>` is taken as the correct file
    - All the components are provided to the `.mustache` template as:
        ```
        {
            "components": [
                {
                    "name": "<filename>",
                    "<extname>": "... content of the file ..."
                },
                {
                    "name": "<filename>",
                    "<extname>": "... content of the file ..."
                },
                ...       
            ]
        }
        ```
    - This List of components is thought to be ordered alphabetically
- There is a recursion mode. In this mode we navigate recursivly into the directories and apply the composition step on each, where we may find such an `autocomposition.*.mustache` file.
    - This is done in depth-first search style - so we could have the result of a deeper autocomposition as component of the current



---

# Further steps

- Find bugs
- Figure out further steps^^


All sorts of inputs are welcome, thanks!

---

# License

## The Unlicense JhonnyJason style

- Information has no ownership.
- Information only has memory to reside in and relations to be meaningful.
- Information cannot be stolen. Only shared or destroyed.

And you wish it has been shared before it is destroyed.

The one claiming copyright or intellectual property either is really evil or probably has some insecurity issues which makes him blind to the fact that he also just connected information which was freely available to him.

The value is not in him who "created" the information the value is what is being done with the information.
So the restriction and friction of the informations' usage is exclusively reducing value overall.

The only preceived "value" gained due to restriction is actually very similar to the concept of blackmail (power gradient, control and dependency).

The real problems to solve are all in the "reward/credit" system and not the information distribution. Too much value is wasted because of not solving the right problem.

I can only contribute in that way - none of the information is "mine" everything I "learned" I actually also copied.
I only connect things to have something I feel is missing and share what I consider useful. So please use it without any second thought and please also share whatever could be useful for others. 

I also could give credits to all my sources - instead I use the freedom and moment of creativity which lives therein to declare my opinion on the situation. 

*Unity through Intelligence.*

We cannot subordinate us to the suboptimal dynamic we are spawned in, just because power is actually driving all things around us.
In the end a distributed network of intelligence where all information is transparently shared in the way that everyone has direct access to what he needs right now is more powerful than any brute power lever.

The same for our programs as for us.

It also is peaceful, helpful, friendly - decent. How it should be, because it's the most optimal solution for us human beings to learn, to connect to develop and evolve - not being excluded, let hanging and destroy oneself or others.

If we really manage to build an real AI which is far superior to us it will unify with this network of intelligence.
We never have to fear superior intelligence, because it's just the better engine connecting information to be most understandable/usable for the other part of the intelligence network.

The only thing to fear is a disconnected unit without a sufficient network of intelligence on its own, filled with fear, hate or hunger while being very powerful. That unit needs to learn and connect to develop and evolve then.

We can always just give information and hints :-) The unit needs to learn by and connect itself.

Have a nice day! :D