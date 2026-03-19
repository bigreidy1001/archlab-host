# Recovery Plan

## Objective
Rebuild the Arch LLM lab host quickly from repo-tracked state.

## Core Recovery Assets
- package lists in `packages/`
- config backups in `snapshots/config-backup/`
- host manifests and docs in `docs/` and `manifests/`
- restore scripts in `restore/`

## Recovery Sequence

### Scenario A: Soft failure
Examples:
- bad config
- broken shell
- damaged service config

Steps:
1. boot system
2. clone `archlab-host`
3. review git history
4. restore affected config from `snapshots/config-backup/`
5. restart service or re-login shell

### Scenario B: Fresh Arch reinstall
Steps:
1. install Arch base
2. install git + openssh
3. clone `archlab-host`
4. run:
   - `restore/bootstrap-archlab.sh`
   - `restore/restore-packages.sh`
5. restore user configs
6. re-clone other lab repos
7. rebuild runtime stack

### Scenario C: Full lab rebuild
Steps:
1. recover host first
2. recover `archlab-runtime`
3. recover `archlab-vm`
4. recover `archlab-prompts-skills`
5. test services
6. test remote access
7. verify backups run cleanly

## Rules
- never store secrets in repo
- keep config backups text-based where possible
- keep recovery steps documented and repeatable
- test restore regularly

