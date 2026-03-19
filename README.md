# archlab-host

# archlab-host

## Purpose
Tracks the Arch Linux host configuration for the LLM lab.

This repo represents the **control plane** of the system:
- shell environment
- system configuration
- bootstrap scripts
- package lists
- tmux lab dashboard
- mount logic
- recovery procedures

## Scope
This repo includes:
- scripts and automation
- sanitized config files
- documentation of system state
- reproducible setup steps

This repo does NOT include:
- secrets or private keys
- large binaries
- full system dumps

## Directory Structure

- bootstrap/ → install + rebuild scripts
- docs/ → system documentation + notes
- mounts/ → mount logic and storage mapping
- packages/ → exported package lists
- scripts/ → utility scripts
- shell/ → zsh config, aliases, prompt
- systemd/ → service definitions (sanitized)
- tmux/ → lab dashboard / monitoring setup

## Goals
- make the host reproducible from scratch
- allow fast rebuild after failure
- track changes over time
- support automation and scripting

## Rebuild Strategy (future)
1. install Arch base
2. clone this repo
3. run bootstrap scripts
4. restore configs
5. verify services

## Notes
- currently single-disk setup (256GB)
- future expansion may include external lab storage
