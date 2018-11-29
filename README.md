# Operable

A Kubernetes DaemonSet for day-2 configuration of users.

Operable is deployed with a Helm chart, and executes a priviledged
container to perform a single, well-defined task.

Operable uses Kubernetes secrets as a mechanism to distribute base64
encoded scripts.  Kubernetes will automatically decode secrets, which
are then mounted into the container as files.  On boot the container
executes `Values.command.exec`, which executes an Ansible playbook
 (`{{ .Values.scripts.playbook }}`) with the `chroot` connection plugin.
Ansible is chrooted into `Values.scripts.chrootMntPath`, which is the
node's root filesystem.  __Sure wish Helm could reference variables in
values.yaml__.

Tests are executed to ensure the desired state is met.  Yeah, yeah I know
imperative blows.

## Why

This project is about establishing a pattern for day-2 operations of
Kubernetes.  

This may also be a __very__ bad idea.

## Similar projects

This project was somewhat inspired by [divingbell][1] and
[pharos-host-upgrades][2].

[1]: https://github.com/openstack/airship-divingbell
[2]: https://github.com/kontena/pharos-host-upgrades

## Usage

### Build images

    $ make build

### Deploy

    $ make deploy

![Alt text](img/ss.png?raw=true "Screen Shot")

### Delete deployment

    $ make delete

### Display the Helm generated kubernetes configs

    $ make template

## Caveats

Requires a [patched][1] version of Ansible's [connection plugin][2] due to a [bug][3].

[1]: TODO
[2]: https://github.com/ansible/ansible/blob/devel/lib/ansible/plugins/connection/chroot.py#L84-L85
[3]: TODO

## License

MIT
