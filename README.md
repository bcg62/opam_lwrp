# opam_lwrp

A first cut at a [Chef](http://chef.io) [LWRP](https://docs.chef.io/lwrp.html) for [OPAM](https://opam.ocaml.org/), an [OCaml](https://ocaml.org/) package manager.

### OPAM installation + init

A Chef *definition* is provided to install OPAM for a given user:

```
opam_setup do
  user "js1"
  group "js1"
  vcs  ["git", "mercurial"]
  # vcs is optional, by default, git, mercurial, and darcs will
  # be installed to use with OPAM
end
```

***NOTE*** since OPAM manages package repos per user, a `user` attribute is required per resource. 

### Package installation

```
opam_package "oasis" do
  action :install
  user "js1"
end
```

### Package removal

```
opam_package "oasis" do
  action :remove
  user "js1"
end
```

### Package updating

```
opam_package "update packages" do
  action :update
  user "js1"
end
```

### Package upgrades

```
opam_package "upgrade packages" do
  action :upgrade
  user "js1"
end
```


#Contributing

Fork this repo, create a feature branch using something like this:
    
```
git checkout -b branch_name
```

and submit a pull request. 

Please send me an email (dparfitt at chef dot io) and let me know if you want to work on any features.

No assholes: only friendly pull requests accepted.

#License

http://www.apache.org/licenses/LICENSE-2.0.html

---

© 2015 Dave Parfitt