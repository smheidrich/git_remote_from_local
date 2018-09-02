git_remote_from_local
=====================

Initialize remote git repository for pushing from local repository.

Also sets up a [*git remote*][git-remote] on the local repository to point to
the remote repository if it doesn't exist already.

[git-remote]: https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes

Requirements
------------

Assumes that *git* is installed and accessible on the remote host.

Role Variables
--------------

### Required

- ``dest`` (required): Directory on the remote host in which the (bare)
  repository will be initialized. Must be absolute and contain no shenanigans
  like ``~`` for home, unless ``repo_url`` is set manually, in which case it
  doesn't matter.

### Optional but highly recommended to be set

- ``src`` (default: ``null``): Path to the source repository on the local
  machine. If ``null``, the repository will stay empty.
- ``remote_name`` (default: ``"{{ inventory_hostname_short }}"``): Name
  of the *git remote* that will be set up in the local repository to point to
  the remote repository.
- ``push`` (default: ``yes``): Whether to perform a ``git push`` after things
  are all set up.

### Completely optional

- ``reinitialize`` (default: ``no``): Whether to re-initialize the remote
  repository on each run. According to the git manual, doing so doesn't do any
  harm, but as a matter of principle I don't want to rely on that.
- ``override_existing_remote`` (default: ``no``): If the local git repository
  already has a *git remote* with the name specified in ``remote_name`` but a
  different URL, the default behaviour is to fail; set this variable to ``yes``
  to override the existing remote instead.
- ``repo_url`` (default: ``"ssh://{{ ansible_user_id }}@{{ inventory_hostname
  }}{{ dest }}"``): URL to the remote that will be used to set the *git
  remote* on the local repository
- TODO: ``src_host``, ``src_remote_user``, ``src_become``, ``src_become_user``


Example Playbook
----------------

    - hosts: example.net
      become: yes
      become_user: remote_user
      roles:
        - role: git_remote_from_local
          vars:
            dest: /home/remote_user/testing/my_repo
            src: ~/my_repo
            remote_name: example_testing
            push: yes


License
-------

MIT


Author Information
------------------

https://github.com/smheidrich

