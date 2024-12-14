#!/bin/bash
#
## Git Bible
#
#A comprehensive system for managing Git states and workflows.
#**Usage**: Source this file or execute specific functions directly.
#**Author**: Andreas Nonslid Håvardsen
#
#The following is variables used for several parts of this config, and should be changed per person.
#
YOUR_NAME="Andreas Nonslid Håvardsen"
YOUR_EMAIL="andreas.nonshaav@hotmail.com"
EDITOR="vim"
#
### **Table of Contents**
#
#- 1. [Set up git credentials to get started](#set-up-git-credentials-to-get-started)    
#  - 1.1 [Set up your identity](#set-up-your-identity)
#  - 1.2 [Set up SSH](#set-up-ssh)
#    - 1.2.1 [Create keys](#create-keys)
#    - 1.2.2 [Add keys to your git host](#add-keys-to-your-git-host)
#      - 1.2.2.1 [GitHub](#github)
#      - 1.2.2.2 [GitLab](#gitlab)
#    - 1.2.3 [Test SSH](#test-ssh)
#  - 1.3 [Better default settings](#better-default-settings)
#
#- 2. [Create Repository](#create-repository)
#  - 2.1 [Create Local Repository](#create-local-repository)
#  - 2.2 [Add Remote](#add-remote)
#    - 2.2.1 [General Remote Setup](#general-remote-setup)
#    - 2.2.2 [Quick Mentions of GitHub and GitLab](#quick-mentions-of-github-and-gitlab)
#  - 2.3 [Guidelines for New Repositories](#guidelines-for-new-repositories)
#    - 2.3.1 [Git Hooks for Automation](#git-hooks-for-automation)
#    - 2.3.2 [Fetch Settings and Other .git Configurations](#fetch-settings-and-other-git-configurations)
#
#- 3. [Recommended Workflow](#recommended-workflow)
#  - 3.1 [Basic Workflow](#basic-workflow)
#    - 3.1.1 [Commit and Push Flow](#commit-and-push-flow)
#    - 3.1.2 [Keeping in Sync with Master/Main](#keeping-in-sync-with-master-main)
#    - 3.1.3 [Handling Interruptions and Switching](#handling-interruptions-and-switching)
#  - 3.2 [Best Practices for Individual Developers](#best-practices-for-individual-developers)
#    - 3.2.1 [Useful Aliases for Workflow](#useful-aliases-for-workflow)
#    - 3.2.2 [Tips to Avoid Common Issues](#tips-to-avoid-common-issues)
#
#- 4. [Submodules](#submodules)
#  - 4.1 [Adding Submodules](#adding-submodules)
#  - 4.2 [Managing Submodule Updates](#managing-submodule-updates)
#  - 4.3 [Resolving Submodule Pointer Issues](#resolving-submodule-pointer-issues)
#  - 4.4 [Recursive Commands and Their Uses](#recursive-commands-and-their-uses)
#
#- 5. [Conflicts](#conflicts)
#  - 5.1 [What Are Conflicts?](#what-are-conflicts)
#    - 5.1.1 [Causes of Conflicts](#causes-of-conflicts)
#    - 5.1.2 [Prevention Strategies](#prevention-strategies)
#  - 5.2 [Resolving Conflicts](#resolving-conflicts)
#    - 5.2.1 [Conflict Basics](#conflict-basics)
#    - 5.2.2 [CLI Tools and Step-by-Step Guide](#cli-tools-and-step-by-step-guide)
#    - 5.2.3 [Visual Tools for Resolving Conflicts](#visual-tools-for-resolving-conflicts)
#  - 5.3 [Ensuring Everything Is Fixed](#ensuring-everything-is-fixed)
#
#- 6. [Reflog and Recovery](#reflog-and-recovery)
#  - 6.1 [Understanding Reflog](#understanding-reflog)
#    - 6.1.1 [What Is the Reflog and How Does It Work?](#what-is-the-reflog-and-how-does-it-work)
#    - 6.1.2 [What Reflog Can and Cannot Do](#what-reflog-can-and-cannot-do)
#  - 6.2 [Using Reflog for Recovery](#using-reflog-for-recovery)
#    - 6.2.1 [Recovering Lost Commits](#recovering-lost-commits)
#    - 6.2.2 [Checking and Restoring Past States](#checking-and-restoring-past-states)
#  - 6.3 [Ensuring Reflog Availability](#ensuring-reflog-availability)
#
#- 7. [Manipulating History](#manipulating-history)
#  - 7.1 [Interactive Rebases](#interactive-rebases)
#    - 7.1.1 [Reordering Commits](#reordering-commits)
#    - 7.1.2 [Squashing and Splitting Commits](#squashing-and-splitting-commits)
#  - 7.2 [Reset, Revert, and Cherry-Pick](#reset-revert-and-cherry-pick)
#    - 7.2.1 [Cleaning Up Mistakes](#cleaning-up-mistakes)
#    - 7.2.2 [Undoing and Modifying Commits](#undoing-and-modifying-commits)
#
#- 8. [Handling Large Repositories](#handling-large-repositories)
#  - 8.1 [Optimizing Performance](#optimizing-performance)
#    - 8.1.1 [Git LFS and Managing Large Files](#git-lfs-and-managing-large-files)
#    - 8.1.2 [Fetch and Clone Settings](#fetch-and-clone-settings)
#  - 8.2 [Useful Commands for Big Repositories](#useful-commands-for-big-repositories)
#    - 8.2.1 [Worktrees for Parallel Work](#worktrees-for-parallel-work)
#    - 8.2.2 [Ignoring Submodules in `git status`](#ignoring-submodules-in-git-status)
#    - 8.2.3 [Sparse Checkouts and Efficient Status Checks](#sparse-checkouts-and-efficient-status-checks)
#
#- 9. [Debugging Git Issues](#debugging-git-issues)
#  - 9.1 [Common Errors and Their Solutions](#common-errors-and-their-solutions)
#  - 9.2 [Diagnosing Repository Problems](#diagnosing-repository-problems)
#    - 9.2.1 [Recovering from Detached HEAD](#recovering-from-detached-head)
#    - 9.2.2 [Fixing Corrupt Repositories](#fixing-corrupt-repositories)
#
#- 10. [Backup and Restore](#backup-and-restore)
#  - 10.1 [Backup Repository](#backup-repository)
#    - 10.1.1 [Using Bundles for Full Backups](#using-bundles-for-full-backups)
#  - 10.2 [Restore Repository](#restore-repository)
#    - 10.2.1 [Restoring from a Bundle](#restoring-from-a-bundle)
#
#- 11. [Logs, Searching, and Visualization](#logs-searching-and-visualization)
#  - 11.1 [Searching the Log](#searching-the-log)
#    - 11.1.1 [Filtering by Author, File, Message, or Time](#filtering-by-author-file-message-or-time)
#    - 11.1.2 [Finding Specific Changes](#finding-specific-changes)
#    - 11.1.3 [Using Partial Hashes in Searches](#using-partial-hashes-in-searches)
#  - 11.2 [Graphing and Visualizing](#graphing-and-visualizing)
#    - 11.2.1 [Visualizing Branches and Commits](#visualizing-branches-and-commits)
#    - 11.2.2 [Recommended Use Cases for Graphs](#recommended-use-cases-for-graphs)
#
#- 12. [Tooling Recommendations](#tooling-recommendations)
#  - 12.1 [List of Tools to Explore](#list-of-tools-to-explore)
#    - 12.1.1 [GUI Clients for Git](#gui-clients-for-git)
#    - 12.1.2 [Diff and Merge Tools](#diff-and-merge-tools)
#    - 12.1.3 [Visualization Plugins and Extensions](#visualization-plugins-and-extensions)
#
## 1. Set up git credentials to get started
#
### 1.1 Set up your identity
#
#Set up your identity using these commands:
#
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

#
### 1.2 Set up SSH
#
#### 1.2.1 Create keys
#
#SSH keys are a secure way to authenticate with remote repositories like GitHub or GitLab.
#
#Generate a new SSH key:
#
#`ssh-keygen -t ed25519 -C ${YOUR_EMAIL}"`
#
#If `ed25519` is not supported, you can use RSA as an alternative:
#
#`ssh-keygen -t rsa -b 4096 -C ${YOUR_EMAIL}`
#
#Passphrases during creation are optional but recommended.
#
#### 1.2.2 Add keys to your git host
#
#Copy your key to add it to your git host:
#
#`cat ~/.ssh/id_ed25519.pub`
#
#Alternatively, use a clipboard tool like `xclip` to copy the content directly.
#
##### 1.2.2.1 GitHub
#
#To add the key on GitHub, go to:  [GitHub SSH Settings](https://github.com/settings/keys)
#
#### 1.2.3 Test SSH
#
#Test the SSH setup by connecting to your git host:
#
#`ssh -T git@github.com`
#
#Expected output for GitHub:
#
#`Hi username! You've successfully authenticated, but GitHub does not provide shell access.`
#
### 1.3 Better default settings
#
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
#
## 2. Create Repository
#
### 2.1 Create Local Repository
#
#To initialize a repository in the current directory: `git init`.
#
#Recommended practice after initial creation:
#
#1. Create a `README.md` to describe the project
#
#2. Create a `.gitignore` file to control what files git will be tracking
#
#A function to automate this process:
#
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
#
#Note: It creates a subdirectory from the current directory, it does not simply create a git repo from within the current directory. Also, if the directory already exists, it will simply attempt to make that into the git repository for you.
#
### 2.2 Add Remote
#
#Create the project on GitHub, and copy the SSH which should look something like `git@github.com:andreasnonslid/git_bible.git`
#
#For adding and updating remotes:
#
alias gSetRemote='git remote add origin'
alias gUpdateRemote='git remote set-url origin'
#
#To view your current remotes:
#
alias gRemotes="git remote -v"
#
#
#
### 2.3 Guidelines for New Repositories
#
#### 2.3.1 Git Hooks for Automation
#
#### 2.3.2 Fetch Settings and Other .git Configurations
#
## 3. Recommended Workflow
#
### 3.1 Basic Workflow
#
#### 3.1.1 Commit and Push Flow
#
#### 3.1.2 Keeping in Sync with Master/Main
#
#### 3.1.3 Handling Interruptions and Switching
#
### 3.2 Best Practices for Individual Developers
#
#### 3.2.1 Useful Aliases for Workflow
#
#### 3.2.2 Tips to Avoid Common Issues
#
## 4. Submodules
#
### 4.1 Adding Submodules
#
### 4.2 Managing Submodule Updates
#
### 4.3 Resolving Submodule Pointer Issues
#
### 4.4 Recursive Commands and Their Uses
#
## 5. Conflicts
#
### 5.1 What Are Conflicts?
#
#### 5.1.1 Causes of Conflicts
#
#### 5.1.2 Prevention Strategies
#
### 5.2 Resolving Conflicts
#
#### 5.2.1 Conflict Basics
#
#### 5.2.2 CLI Tools and Step-by-Step Guide
#
#### 5.2.3 Visual Tools for Resolving Conflicts
#
### 5.3 Ensuring Everything Is Fixed
#
## 6. Reflog and Recovery
#
### 6.1 Understanding Reflog
#
#### 6.1.1 What Is the Reflog and How Does It Work?
#
#### 6.1.2 What Reflog Can and Cannot Do
#
### 6.2 Using Reflog for Recovery
#
#### 6.2.1 Recovering Lost Commits
#
#### 6.2.2 Checking and Restoring Past States
#
### 6.3 Ensuring Reflog Availability
#
## 7. Manipulating History
#
### 7.1 Interactive Rebases
#
#### 7.1.1 Reordering Commits
#
#### 7.1.2 Squashing and Splitting Commits
#
### 7.2 Reset, Revert, and Cherry-Pick
#
#### 7.2.1 Cleaning Up Mistakes
#
#### 7.2.2 Undoing and Modifying Commits
#
## 8. Handling Large Repositories
#
### 8.1 Optimizing Performance
#
#### 8.1.1 Git LFS and Managing Large Files
#
#### 8.1.2 Fetch and Clone Settings
#
### 8.2 Useful Commands for Big Repositories
#
#### 8.2.1 Worktrees for Parallel Work
#
#### 8.2.2 Ignoring Submodules in `git status`
#
#### 8.2.3 Sparse Checkouts and Efficient Status Checks
#
## 9. Debugging Git Issues
#
### 9.1 Common Errors and Their Solutions
#
### 9.2 Diagnosing Repository Problems
#
#### 9.2.1 Recovering from Detached HEAD
#
#### 9.2.2 Fixing Corrupt Repositories
#
## 10. Backup and Restore
#
### 10.1 Backup Repository
#
#### 10.1.1 Using Bundles for Full Backups
#
### 10.2 Restore Repository
#
#### 10.2.1 Restoring from a Bundle
#
## 11. Logs, Searching, and Visualization
#
### 11.1 Searching the Log
#
#### 11.1.1 Filtering by Author, File, Message, or Time
#
#### 11.1.2 Finding Specific Changes
#
#### 11.1.3 Using Partial Hashes in Searches
#
### 11.2 Graphing and Visualizing
#
#### 11.2.1 Visualizing Branches and Commits
#
#### 11.2.2 Recommended Use Cases for Graphs
#
## 12. Tooling Recommendations
#
### 12.1 List of Tools to Explore
#
#### 12.1.1 GUI Clients for Git
#
#### 12.1.2 Diff and Merge Tools
#
#### 12.1.3 Visualization Plugins and Extensions
#
### Source this file to use functions and aliases:
#
#source git_bible.sh
