# Ten Minute Rebuild Goal

## Goal
Get from fresh Arch install to working lab foundation fast.

## Minimum viable rebuild
1. get online
2. install:
   - git
   - openssh
   - zsh
   - tmux
   - networkmanager
3. clone `archlab-host`
4. run bootstrap script
5. restore packages
6. restore configs
7. re-clone remaining repos

## Command sequence
```bash
sudo pacman -Syu --needed git openssh
git clone git@github.com:bigreidy1001/archlab-host.git ~/lab/repos/archlab-host
cd ~/lab/repos/archlab-host
./restore/bootstrap-archlab.sh
./restore/restore-packages.sh


Then

re-clone runtime, vm, prompts repos

test shell

test tmux

test network

continue with runtime/service recovery


Note: in markdown, keep the inner code fence correct. If `nano` gets weird, use triple tildes inside instead of triple backticks.

Use this safer version instead:

```md
# Ten Minute Rebuild Goal

## Goal
Get from fresh Arch install to working lab foundation fast.

## Minimum viable rebuild
1. get online
2. install:
   - git
   - openssh
   - zsh
   - tmux
   - networkmanager
3. clone `archlab-host`
4. run bootstrap script
5. restore packages
6. restore configs
7. re-clone remaining repos

## Command sequence

~~~bash
sudo pacman -Syu --needed git openssh
git clone git@github.com:bigreidy1001/archlab-host.git ~/lab/repos/archlab-host
cd ~/lab/repos/archlab-host
./restore/bootstrap-archlab.sh
./restore/restore-packages.sh
~~~

## Then
- re-clone runtime, vm, prompts repos
- test shell
- test tmux
- test network
- continue with runtime/service recovery
