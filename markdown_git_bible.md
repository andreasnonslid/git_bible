!/bin/bash

# Git Bible

A comprehensive system for managing Git states and workflows.

**Usage**: Source this file or execute specific functions directly.

**Author**: Andreas Nonslid Håvardsen

The following is variables used for several parts of this config, and should be changed per person.

```bash
YOUR_NAME="Andreas Nonslid Håvardsen"
YOUR_EMAIL="andreas.nonshaav@hotmail.com"
EDITOR="vim"
```

## **Table of Contents**
- 1. [Set up git credentials to get started](#1-set-up-git-credentials-to-get-started)    
  - 1.1 [Set up your identity](#11-set-up-your-identity)
  - 1.2 [Set up SSH](#12-set-up-ssh)
    - 1.2.1 [Create keys](#121-create-keys)
    - 1.2.2 [Add keys to your git host](#122-add-keys-to-your-git-host)
      - 1.2.2.1 [GitHub](#1221-github)
      - 1.2.2.2 [GitLab](#1222-gitlab)
    - 1.2.3 [Test SSH](#123-test-ssh)
  - 1.3 [Better default settings](#13-better-default-settings)

- 2. [Create Repository](#2-create-repository)
  - 2.1 [Create Local Repository](#21-create-local-repository)
  - 2.2 [Add Remote](#22-add-remote)
    - 2.2.1 [General Remote Setup](#221-general-remote-setup)
    - 2.2.2 [Quick Mentions of GitHub and GitLab](#222-quick-mentions-of-github-and-gitlab)
  - 2.3 [Guidelines for New Repositories](#23-guidelines-for-new-repositories)
    - 2.3.1 [Git Hooks for Automation](#231-git-hooks-for-automation)
    - 2.3.2 [Fetch Settings and Other .git Configurations](#232-fetch-settings-and-other-git-configurations)

- 3. [Recommended Workflow](#3-recommended-workflow)
  - 3.1 [Basic Workflow](#31-basic-workflow)
    - 3.1.1 [Commit and Push Flow](#311-commit-and-push-flow)
    - 3.1.2 [Keeping in Sync with Master/Main](#312-keeping-in-sync-with-master-main)
    - 3.1.3 [Handling Interruptions and Switching](#313-handling-interruptions-and-switching)
  - 3.2 [Best Practices for Individual Developers](#32-best-practices-for-individual-developers)
    - 3.2.1 [Useful Aliases for Workflow](#321-useful-aliases-for-workflow)
    - 3.2.2 [Tips to Avoid Common Issues](#322-tips-to-avoid-common-issues)

- 4. [Submodules](#4-submodules)
  - 4.1 [Adding Submodules](#41-adding-submodules)
  - 4.2 [Managing Submodule Updates](#42-managing-submodule-updates)
  - 4.3 [Resolving Submodule Pointer Issues](#43-resolving-submodule-pointer-issues)
  - 4.4 [Recursive Commands and Their Uses](#44-recursive-commands-and-their-uses)

- 5. [Conflicts](#5-conflicts)
  - 5.1 [What Are Conflicts?](#51-what-are-conflicts)
    - 5.1.1 [Causes of Conflicts](#511-causes-of-conflicts)
    - 5.1.2 [Prevention Strategies](#512-prevention-strategies)
  - 5.2 [Resolving Conflicts](#52-resolving-conflicts)
    - 5.2.1 [Conflict Basics](#521-conflict-basics)
    - 5.2.2 [CLI Tools and Step-by-Step Guide](#522-cli-tools-and-step-by-step-guide)
    - 5.2.3 [Visual Tools for Resolving Conflicts](#523-visual-tools-for-resolving-conflicts)
  - 5.3 [Ensuring Everything Is Fixed](#53-ensuring-everything-is-fixed)

- 6. [Reflog and Recovery](#6-reflog-and-recovery)
  - 6.1 [Understanding Reflog](#61-understanding-reflog)
    - 6.1.1 [What Is the Reflog and How Does It Work?](#611-what-is-the-reflog-and-how-does-it-work)
    - 6.1.2 [What Reflog Can and Cannot Do](#612-what-reflog-can-and-cannot-do)
  - 6.2 [Using Reflog for Recovery](#62-using-reflog-for-recovery)
    - 6.2.1 [Recovering Lost Commits](#621-recovering-lost-commits)
    - 6.2.2 [Checking and Restoring Past States](#622-checking-and-restoring-past-states)
  - 6.3 [Ensuring Reflog Availability](#63-ensuring-reflog-availability)

- 7. [Manipulating History](#7-manipulating-history)
  - 7.1 [Interactive Rebases](#71-interactive-rebases)
    - 7.1.1 [Reordering Commits](#711-reordering-commits)
    - 7.1.2 [Squashing and Splitting Commits](#712-squashing-and-splitting-commits)
  - 7.2 [Reset, Revert, and Cherry-Pick](#72-reset-revert-and-cherry-pick)
    - 7.2.1 [Cleaning Up Mistakes](#721-cleaning-up-mistakes)
    - 7.2.2 [Undoing and Modifying Commits](#722-undoing-and-modifying-commits)

- 8. [Handling Large Repositories](#8-handling-large-repositories)
  - 8.1 [Optimizing Performance](#81-optimizing-performance)
    - 8.1.1 [Git LFS and Managing Large Files](#811-git-lfs-and-managing-large-files)
    - 8.1.2 [Fetch and Clone Settings](#812-fetch-and-clone-settings)
  - 8.2 [Useful Commands for Big Repositories](#82-useful-commands-for-big-repositories)
    - 8.2.1 [Worktrees for Parallel Work](#821-worktrees-for-parallel-work)
    - 8.2.2 [Ignoring Submodules in `git status`](#822-ignoring-submodules-in-git-status)
    - 8.2.3 [Sparse Checkouts and Efficient Status Checks](#823-sparse-checkouts-and-efficient-status-checks)

- 9. [Debugging Git Issues](#9-debugging-git-issues)
  - 9.1 [Common Errors and Their Solutions](#91-common-errors-and-their-solutions)
  - 9.2 [Diagnosing Repository Problems](#92-diagnosing-repository-problems)
    - 9.2.1 [Recovering from Detached HEAD](#921-recovering-from-detached-head)
    - 9.2.2 [Fixing Corrupt Repositories](#922-fixing-corrupt-repositories)

- 10. [Backup and Restore](#10-backup-and-restore)
  - 10.1 [Backup Repository](#101-backup-repository)
    - 10.1.1 [Using Bundles for Full Backups](#1011-using-bundles-for-full-backups)
  - 10.2 [Restore Repository](#102-restore-repository)
    - 10.2.1 [Restoring from a Bundle](#1021-restoring-from-a-bundle)

- 11. [Logs, Searching, and Visualization](#11-logs-searching-and-visualization)
  - 11.1 [Searching the Log](#111-searching-the-log)
    - 11.1.1 [Filtering by Author, File, Message, or Time](#1111-filtering-by-author-file-message-or-time)
    - 11.1.2 [Finding Specific Changes](#1112-finding-specific-changes)
    - 11.1.3 [Using Partial Hashes in Searches](#1113-using-partial-hashes-in-searches)
  - 11.2 [Graphing and Visualizing](#112-graphing-and-visualizing)
    - 11.2.1 [Visualizing Branches and Commits](#1121-visualizing-branches-and-commits)
    - 11.2.2 [Recommended Use Cases for Graphs](#1122-recommended-use-cases-for-graphs)

- 12. [Tooling Recommendations](#12-tooling-recommendations)
  - 12.1 [List of Tools to Explore](#121-list-of-tools-to-explore)
    - 12.1.1 [GUI Clients for Git](#1211-gui-clients-for-git)
    - 12.1.2 [Diff and Merge Tools](#1212-diff-and-merge-tools)
    - 12.1.3 [Visualization Plugins and Extensions](#1213-visualization-plugins-and-extensions)

# 1. Set up git credentials to get started

## 1.1 Set up your identity

Set up your identity using these commands:

```bash
# Sets globals as defined in the top of this file
git config --global user.name "$YOUR_NAME"
git config --global user.email "$YOUR_EMAIL"

# Check global settings
alias gViewConfig="git config --global --list"
alias gName="git config --global user.name"
alias gEmail="git config --global user.email"

# Set local identity (per repo)
alias gSetName="git config user.name" # add your desired name after
alias gSetEmail="git config user.email" # add your desired email after

```

## 1.2 Set up SSH

### 1.2.1 Create keys

SSH keys are a secure way to authenticate with remote repositories like GitHub or GitLab.

Generate a new SSH key:

`ssh-keygen -t ed25519 -C ${YOUR_EMAIL}"`

If `ed25519` is not supported, you can use RSA as an alternative:

`ssh-keygen -t rsa -b 4096 -C ${YOUR_EMAIL}`

Passphrases during creation are optional but recommended.

### 1.2.2 Add keys to your git host

Copy your key to add it to your git host:

`cat ~/.ssh/id_ed25519.pub`

Alternatively, use a clipboard tool like `xclip` to copy the content directly.

`xclip -sel clip ~/.ssh/id_ed25519.pub`

Then we make sure to add it to the SSH agent to make sure it is actually used during git operations:

`eval "$(ssh-agent -s)"`

`ssh-add ~/.ssh/id_ed25519`

Verify it is loaded:

`ssh-add -l`

#### 1.2.2.1 GitHub

To add the key on GitHub, go to:  [GitHub SSH Settings](https://github.com/settings/keys)

### 1.2.3 Test SSH

Test the SSH setup by connecting to your git host:

`ssh -T git@github.com`

Expected output for GitHub:

`Hi username! You've successfully authenticated, but GitHub does not provide shell access.`

## 1.3 Better default settings

```bash
git config --global core.editor "$EDITOR"              # Set the default editor for Git commands (e.g., commit messages)
git config --global color.ui auto                     # Enable colorized output for better readability
git config --global init.defaultBranch main           # Use 'main' as the default branch for new repositories
git config --global credential.helper "cache --timeout=3600" # Cache credentials for 1 hour to avoid frequent prompts

git config --global core.fileMode false               # Ignore file mode changes (e.g., permission changes)

git config --global pull.rebase true                  # Use rebase instead of merge on pull to keep history clean
git config --global branch.autoSetupRebase always     # Automatically rebase all branches when pulling
git config --global merge.ff only                     # Allow only fast-forward merges to maintain a linear history

git config --global merge.conflictstyle diff3         # Show inline conflict markers with detailed context

git config --global status.short true                 # Display a concise status output
git config --global status.branch true                # Include branch information in the status output

git config --global log.decorate true                 # Show branch and tag names in logs
git config --global log.abbrevCommit true             # Use abbreviated commit hashes in logs
git config --global log.date relative                 # Show commit dates relative to the current time (e.g., "2 days ago")

git config --global fetch.prune true                  # Automatically remove stale remote-tracking branches during fetch
git config --global push.default simple               # Push only the current branch to its upstream by default

git config --global core.whitespace fix,-indent-with-non-tab,trailing-space,cr-at-eol # Highlight whitespace issues in diffs

git config --global color.diff.meta "yellow bold"     # Use yellow bold for metadata in diffs
git config --global color.diff.frag "magenta bold"    # Use magenta bold for fragment headers in diffs
git config --global color.diff.old "red bold"         # Use red bold for removed lines in diffs
git config --global color.diff.new "green bold"       # Use green bold for added lines in diffs

git config --global rerere.enabled true               # Enable reuse recorded resolution (remembers conflict resolutions)
```

# 2. Create Repository

## 2.1 Create Local Repository

To initialize a repository in the current directory: `git init`.

Recommended practice after initial creation:

1. Create a `README.md` to describe the project

2. Create a `.gitignore` file to control what files git will be tracking

A function to automate this process:

```bash
function gCreateLocalRepo() {
    # Validate that an argument is provided
    if [ -z "$1" ]; then
        echo "Error: Repository name not provided."
        echo "Usage: ${PREFIX}CreateLocalRepo <repository-name>"
        return 1
    fi

    # Create the directory and initialize the repository
    mkdir "$1" || { echo "Directory already exists or cannot be created."; return 1; }
    cd "$1" || exit
    git init
    echo "# $1" > README.md
    echo "build/" > .gitignore
    git add README.md .gitignore
    git commit -m "Initial commit"
    echo "Repository '$1' initialized successfully."
}
```

Note: It creates a subdirectory from the current directory, it does not simply create a git repo from within the current directory. Also, if the directory already exists, it will simply attempt to make that into the git repository for you.

## 2.2 Add Remote

Create the project on GitHub, and copy the SSH which should look something like `git@github.com:andreasnonslid/git_bible.git`

For adding and updating remotes:

```bash
alias gSetRemote='git remote add origin'
alias gUpdateRemote='git remote set-url origin'
```

To view your current remotes:

```bash
alias gRemotes="git remote -v"
```

## 2.3 Guidelines for New Repositories

### 2.3.1 Git Hooks for Automation

Git hooks are scripts that Git automatically executes before or after specific events in the Git lifecycle.

These are stored in `.git/hooks/`.

There are two types, client-side and server-side.

Here’s a more concise and digestible explanation of common Git hooks:

---

Common Client-Side Hooks

1. **`pre-commit`**  
   Runs before a commit is created. Use it for code linting, formatting, or preventing commits with bad patterns.

2. **`prepare-commit-msg`**  
   Runs before the commit message editor opens. Use it to prepopulate commit messages with templates or branch names.

3. **`commit-msg`**  
   Runs after the commit message is written. Use it to enforce commit message formatting rules.

4. **`post-commit`**  
   Runs after a commit is created. Use it to log commit info or trigger analytics.

5. **`pre-push`**  
   Runs before pushing to a remote. Use it to run tests, prevent sensitive files from being pushed, or validate branches.

6. **`post-checkout`**  
   Runs after switching branches. Use it to update dependencies or perform environment-specific tasks.

7. **`post-merge`**  
   Runs after merging branches. Use it to install dependencies or run migrations if certain files (e.g., `package.json`) changed.

Common Server-Side Hooks

1. **`pre-receive`**  
   Runs before a push is accepted on the server. Use it to validate incoming changes or enforce branch protection rules.

2. **`update`**  
   Runs when a branch is updated. Use it for per-branch validation, such as preventing force pushes.

3. **`post-receive`**  
   Runs after changes are accepted. Use it to trigger CI/CD pipelines or send notifications.

An example on how to create on such hook:

`cd .git/hooks/`

`echo "echo \"Running pre-commit hook...\"" > pre-commit`

`chmod +x pre-commit`

To make the hook tracked, create a `hooks/` directory at the root of the Git repo:

`mkdir -p hooks`

`mv .git/hooks/pre-commit hooks/`

Instruct git to use the `hooks/` directory as the hooks path:

`git config core.hooksPath hooks`

Others using this repository will have to make it executable (`chmod`) and activate it as well, using the same command above.

### 2.3.2 Fetch Settings and Other .git Configurations

# 3. Recommended Workflow

## 3.1 Basic Workflow

### 3.1.1 Commit and Push Flow

### 3.1.2 Keeping in Sync with Master/Main

### 3.1.3 Handling Interruptions and Switching

## 3.2 Best Practices for Individual Developers

### 3.2.1 Useful Aliases for Workflow

### 3.2.2 Tips to Avoid Common Issues

# 4. Submodules

## 4.1 Adding Submodules

## 4.2 Managing Submodule Updates

## 4.3 Resolving Submodule Pointer Issues

## 4.4 Recursive Commands and Their Uses

# 5. Conflicts

## 5.1 What Are Conflicts?

### 5.1.1 Causes of Conflicts

### 5.1.2 Prevention Strategies

## 5.2 Resolving Conflicts

### 5.2.1 Conflict Basics

### 5.2.2 CLI Tools and Step-by-Step Guide

### 5.2.3 Visual Tools for Resolving Conflicts

## 5.3 Ensuring Everything Is Fixed

# 6. Reflog and Recovery

## 6.1 Understanding Reflog

### 6.1.1 What Is the Reflog and How Does It Work?

### 6.1.2 What Reflog Can and Cannot Do

## 6.2 Using Reflog for Recovery

### 6.2.1 Recovering Lost Commits

### 6.2.2 Checking and Restoring Past States

## 6.3 Ensuring Reflog Availability

# 7. Manipulating History

## 7.1 Interactive Rebases

### 7.1.1 Reordering Commits

### 7.1.2 Squashing and Splitting Commits

## 7.2 Reset, Revert, and Cherry-Pick

### 7.2.1 Cleaning Up Mistakes

### 7.2.2 Undoing and Modifying Commits

# 8. Handling Large Repositories

## 8.1 Optimizing Performance

### 8.1.1 Git LFS and Managing Large Files

### 8.1.2 Fetch and Clone Settings

## 8.2 Useful Commands for Big Repositories

### 8.2.1 Worktrees for Parallel Work

### 8.2.2 Ignoring Submodules in `git status`

### 8.2.3 Sparse Checkouts and Efficient Status Checks

# 9. Debugging Git Issues

## 9.1 Common Errors and Their Solutions

## 9.2 Diagnosing Repository Problems

### 9.2.1 Recovering from Detached HEAD

### 9.2.2 Fixing Corrupt Repositories

# 10. Backup and Restore

## 10.1 Backup Repository

### 10.1.1 Using Bundles for Full Backups

## 10.2 Restore Repository

### 10.2.1 Restoring from a Bundle

# 11. Logs, Searching, and Visualization

## 11.1 Searching the Log

### 11.1.1 Filtering by Author, File, Message, or Time

### 11.1.2 Finding Specific Changes

### 11.1.3 Using Partial Hashes in Searches

## 11.2 Graphing and Visualizing

### 11.2.1 Visualizing Branches and Commits

### 11.2.2 Recommended Use Cases for Graphs

# 12. Tooling Recommendations

## 12.1 List of Tools to Explore

### 12.1.1 GUI Clients for Git

### 12.1.2 Diff and Merge Tools

### 12.1.3 Visualization Plugins and Extensions

## Source this file to use functions and aliases:

source git_bible.sh
